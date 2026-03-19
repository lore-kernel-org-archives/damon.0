Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D945C38E5DA;
	Thu, 19 Mar 2026 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930879; cv=none; b=Vzbi9sGRQQavxUXJG1iPpk9vd60JAay3+dqd+4X+SSmQgbtxHSAnAmhMpSaHfe0rBCQ1UxoXU7tkctyxPNvVC4gzJ9IkB2Fyzj2BkY7Jb22BuzCTilueB+koL92w1ultLtOzt9W2KBYaEl/r1aBMSw+SuNcaiakc8sEEdgzozak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930879; c=relaxed/simple;
	bh=QPvwXTWdLaBTtuwZnmO/qS7QuZy5AGitWuAjPdnxmHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhVRxxKt0KMEjn5RDCCilfGfCBzHmKf0EntTn9xlXMqbytzMxMsPzQYZeaSm0hpCsjbwHaXUdgZ0IS+mnhVlOe/nlpgnWqutVMPcJeQ/TlkwWtlCOul7V7XEOkfvoL7M6a/jzkFLEL8an0tJmn3WsQXqGTpZ/nICiwdFIUMKvaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOvmnnOv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOvmnnOv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8FAC19425;
	Thu, 19 Mar 2026 14:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773930879;
	bh=QPvwXTWdLaBTtuwZnmO/qS7QuZy5AGitWuAjPdnxmHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FOvmnnOvg2mEHRMZzebQTmrbuUoWrScNc476HIfegGUcK8PMwOs+SHj81CzqyBQ6D
	 QoQAQGN1c2VxN+kn4MldF/JebdDEf7YQ9GHw6CoXSYXRtHbX2WlSzVJzmi/jyTOmIp
	 Jw6tTlaM8f7Pb+fbIwt3zUauI/embi7CJQNEOeXIzf2M1wi/8Ow/+b5JaVwHXXZDK5
	 puKFHBw+h2zleFlajvDNhOBUq0ZRGbTKSXiAfHigvhtRo1BBe3oaF9wewRSbOIUXIE
	 R1j9nM3v90+f9zuqtzTIB2iuRuXEVFzaR0axDRgYYjvfsYbiZsLo/o8efhbA9ELtYO
	 S7vnT8uULGQmw==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: reset nr_dests on allocation failure in damos_commit_dests()
Date: Thu, 19 Mar 2026 07:34:36 -0700
Message-ID: <20260319143437.82957-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <B08CB6C4-72EE-48AD-9AA5-16CDA175B193@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 19 Mar 2026 07:07:18 +0000 Josh Law <objecting@objecting.org> wrote:

> 
> 
> On 19 March 2026 04:33:09 GMT, SeongJae Park <sj@kernel.org> wrote:
> >Hello Josh,
> >
> >On Wed, 18 Mar 2026 21:49:39 +0000 Josh Law <objecting@objecting.org> wrote:
> >
> >> damos_commit_dests() frees the old node_id_arr and weight_arr before
> >> reallocating.  If kmalloc_array() fails, the function returns -ENOMEM but
> >> leaves dst->nr_dests at its previous value.  A subsequent call with the
> >> same nr_dests will skip the reallocation (the sizes match), and the loop
> >> at the end will dereference the now-NULL array pointers.
> >
> >Nice catch.  But, this is a sort of intended behavior.
> >
> >The idea behind the code is that, if the function fails, the caller will
> >not resue 'dst' but discard it.  Hence the function is only ensuring the 'dst'
> >after the failure can be deallocated using the deallocation helper function
> >like 'damon_destroy_scheme()'.  For this, the function is setting weight_arr as
> >NULL in the allocation failure.
> >
> >> 
> >> Fix this by resetting dst->nr_dests to 0 immediately after freeing the
> >> old arrays, so any later call always enters the reallocation path.
> >> 
> >> Fixes: cbc4eea4ffb5 ("mm/damon/core: commit damos->migrate_dests")
> >> Signed-off-by: Josh Law <objecting@objecting.org>
> >> ---
> >>  mm/damon/core.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/mm/damon/core.c b/mm/damon/core.c
> >> index 7f74982535ac..e233eb84a2d5 100644
> >> --- a/mm/damon/core.c
> >> +++ b/mm/damon/core.c
> >> @@ -1060,6 +1060,7 @@ static int damos_commit_dests(struct damos_migrate_dests *dst,
> >>  	if (dst->nr_dests != src->nr_dests) {
> >>  		kfree(dst->node_id_arr);
> >>  		kfree(dst->weight_arr);
> >> +		dst->nr_dests = 0;
> >>  
> >>  		dst->node_id_arr = kmalloc_array(src->nr_dests,
> >>  			sizeof(*dst->node_id_arr), GFP_KERNEL);
> >
> >Someone (including a part of myself) could argue anyway initializing the field
> >is better to do, for code readability and completeness of the data structure.
> >But I'd argue that might only encourage calllers to reuse 'dst' after the
> >failure.  Also, the 0 nr_dests could still meaning something incorrect, if the
> >first kmalloc_array() for node_id_arr success but the following kmalloc_array()
> >for weight_arr failed.  In the case, nr_dests is zero, but the size of
> >node_id_arr is not zero.
> >
> >I think the intention behind the code is not well documented and that might
> >confused you.  Sorry if that was the case.  I think this could better be
> >documented by adding comments for the function.  The single line comment in the
> >function body was for the purpose, but having more detailed comments at the top
> >of the function may be better.  If you'd like to send such documentation,
> >please do so.  If not, I will do that.  Whatever is your preference, thank you
> >for finding and sharing this room to improve!
> >
> >... And, this patch helped me finding something actually broken.  As I
> >mentioned above, callers of damos_commit_dests() are assumed to discard the
> >'dst' when the function failed.  And the only caller, sysfs.c, does so, except
> >for the final commit to the running context (kdmond->damon_ctx).  It can result
> >in DAMON running with the incorrect data structure, doing NULL dereference.
> >Similar issue might exist for DAMON_RECLAIM and DAMON_LRU_SORT.  Because those
> >modules use only limited parameters, there might be not.  I will double check
> >and make a fix soon.  Again, thank you for helping me finding this issue, Josh!
> >
> >
> >Thanks,
> >SJ
> 
> 
> Well, I guess hardening this patch is useful for then..

Agreed.  Maybe adding another sanity check (e.g., WARN_ON(dst->nr_dests &&
(!dst->weight_arr || !dst->node_id_arr), "foo")) under DAMON_DEBUG_SANITY might
make sense.


Thanks,
SJ

[...]
