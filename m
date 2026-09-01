Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27325FDA7;
	Tue,  1 Sep 2026 05:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788240709; cv=none; b=WCj7ctCXP+lbC0jGnFoVSdGFfoxPmVcoOgRy5D8AY5c5Uc+3zjQT24bfgXHrp/nroFo1+Dn9K36Aut9Jv8DGxFFzaTeqOyNnCHKzbq4Cs6yznTXpVJx6vzkoDgrxGbcJkvs7j4Q2HgX5R0L01RhJzDCjw1NwNQGx5ZcCHgt667g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788240709; c=relaxed/simple;
	bh=0yiuOGbXHR0lTMuwvwzCmuy+l2SGtPRLfXhGg+VjBpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJIoLj2xyEP5yBNDGceoPr4zgdmLJ0hZ3Drhj4phJXz0z/lWaqmgt1lc5hc+Hc7IlZAln17f7eA1HEDnO31CwQeNX2SJ/nOXUpHKFm48TUIbenuuNPcM8OzvjChuTRtfd2ivF0JLElg0vaSZ1tPYf+sncrlRbykgrDUhS77gZus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJiopimI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJiopimI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4381F000E9;
	Tue,  1 Sep 2026 05:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788240707;
	bh=5yv5dZp1OovU3o/tMe/s53rqpohnpt5v6m7qLxX7u8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KJiopimIdEwNANCZnewWxQ09EWw42GY1qt1ibcigOZuwffyD2+SajimU8l1c0qrFf
	 hSYl9hcluqz9sisuiVH4ucu4xfhA9VPnp7+qbSwQqE3iCdTGG04eddL0xC1eghNKS/
	 Vh+8oxsvug8FQEA+jc2DQ6juo7zgNvAFmjDKueln85HS0QH8X6yCBAop0vt4JrHDmB
	 RDZY4NsJwBxGSh1fytV1LmIJ0CRuURf7t9Nwz/R1t2t4pWSxdZR109V3Z3A89i9TUB
	 smPDsNCwEFqdhzbop9L/bfUkXzXdXhjRFIGZ4K2WS0q+tB0rWRswv5MiDeuix8Q1qv
	 wuRBFVomwGgyQ==
From: SJ Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SJ Park <sj@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 3/3] Docs/mm/damon/design: Document hugepage_mem_bp target metric
Date: Mon, 31 Aug 2026 22:31:39 -0700
Message-ID: <20260901053139.24079-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <893af75e-690b-48f0-9cc9-afe07c05565c@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 1 Sep 2026 08:20:50 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> On 9/1/2026 3:47 AM, SJ Park wrote:
> > On Mon, 31 Aug 2026 13:00:26 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> Hi,
> > 
> >>
> >>
> >> On 8/31/26 8:45 AM, Randy Dunlap wrote:
> >>> Hi,
> >>>
> >>> On 8/31/26 7:47 AM, SJ Park wrote:
> >>>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >>>>
> >>>> Document hugepage_mem_bp metric exposed by sysfs.
> >>>>
> >>>> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >>>> Reviewed-by: SJ Park <sj@kernel.org>
> >>>> Signed-off-by: SJ Park <sj@kernel.org>
> >>>> ---
> >>>>  Documentation/mm/damon/design.rst | 2 ++
> >>>>  1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> >>>> index aed6cb1cf4831..a8c163475ef2b 100644
> >>>> --- a/Documentation/mm/damon/design.rst
> >>>> +++ b/Documentation/mm/damon/design.rst
> >>>> @@ -713,6 +713,8 @@ mechanism tries to make ``current_value`` of ``target_metric`` be same to
> >>>>    bp (1/10,000).
> >>>>  - ``node_eligible_mem_bp``: Scheme target access pattern-eligible memory ratio
> >>>>    of a node in bp (1/10,000).
> >>>> +- ``hugepage_mem_bp``: Total huge page to total used memory ratio in bp
> >>>> +  (1/10,000).
> >>>>  
> >>>>  ``nid`` is optionally required for ``node_mem_used_bp``, ``node_mem_free_bp``,
> >>>>  ``node_memcg_used_bp``, ``node_memcg_free_bp`` and ``node_eligible_mem_bp`` to
> >>>
> >>> I've looked thru the entire design.rst file and cannot find anything telling
> >>> me (or anyone) what "bp" means.  Explain??
> >>
> >> OK, I found it on the internet. I still think that it would be a
> >> good idea to say "basis point" one time (the first time that it is used).
> > 
> > You are right, and I agree.  I will add that clarification before the next
> > merge window.
> > 
> >>
> >>
> >> -- 
> >> ~Randy
> > 
> > 
> > Thanks,
> > SJ
> 
> SJ, should I submit a new patch to fix design.rst?

The lack of the clarification of 'bp' was introduced before this patch.  So I
don't think you should do that on your own.

Of course you could do if you want to.  But that should be a separate patch in
my opinion.  Let me know if you will.  Otherwise I will do.


Thanks,
SJ

[...]
