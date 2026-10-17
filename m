Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49DD368D74;
	Sat, 17 Oct 2026 00:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792195221; cv=none; b=A36nwyhHk1uvY5BtHxUfMrilbQ6+EC78stsNEA/ijJc6GZMbMsz876gjmldGjqsEmqPQLMCTRzq7/NfX7aBnKpzxmVyMwpOlQduJ6GQkHj7zG/sIYGyViSiED+sjxOh720PJAF66JdSm/ycEcG/YGBFtHXbhClleETs5AgpJ9C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792195221; c=relaxed/simple;
	bh=i9zKLdNcKo9YWS1g3aVivo6LBgLE830YLqDYVybAJkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uce2bBauBSFBMIkKx6s0OwAELOKya03vHg8VWDV9+v9Pw9gYfqlYESB4Y/1EJ5o4AUC1KHnRbYmgGS1XZ+JOeJ/wPHTxqGRQq57XC2L5rUJqAs66Xhgc/H5qQkxNelTjlHewcYIfBwDBnxBCYxuZMtkOcmZeheoSH7zJ7CqrMqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YT/Kniwn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YT/Kniwn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44CE1F000C4;
	Sat, 17 Oct 2026 00:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792195220;
	bh=ShCsr8VpmfSVrYE38tsQnynm8VtQ88LG2PyXK4mEIVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YT/Kniwnli+s29yW9eREh6MrxOIb3XDAYCRJjjRU3iAFlX4Oax5cV3OHzXWrGRey4
	 bFO67sh6yb+zwA2ElR6CrK26oeD8wD2nT0urKNWD4Yw7YjlVS+Oh4Dtc96+PXgWhEG
	 rI5oltlo7G2B2tfYJdEdBZwS+Ys1Or4rMvJYUcgzSYxi7n4zo4ain6IDRw5/LdYAeL
	 G5Myn5WbJzSFWUYa67ozwJpjnK6syDV+TdXK1RQY4pv8gzKAxxzfjGc3MkpH8CIq5N
	 6IgcpXVJq5pRsI49kaMj/czV0hdUb18bzlaq4y32H+PQAki3gGlItpIdpaVT+cC9lc
	 E6Zrqu8at65Dw==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/reclaim: improve grammar and style
Date: Fri, 16 Oct 2026 17:00:12 -0700
Message-ID: <20261017000013.97300-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179216914308.58773.4774391289742300524.b4-reply@b4>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 17 Oct 2026 00:45:43 +0800 Aveline Noir <jm5905938@gmail.com> wrote:

> Hi SJ,
> 
> On Fri, 16 Oct 2026 07:29:21 -0700, SJ Park wrote:
> 
> > If both of you agree to my abovely suggested/agreed changes ('s/page out/ pages
> > out those/' and 's/records/charges/'), I will update this patch in damon/next
> > tree with those changes.

I was wrongly thinking this patch is already in damon/next.  It is not.  I am
waiting for Manuel's replies to my review.  So I will not do the update of this
patch on my own but wait for Manuel's answer and revisioning.

> 
> Both changes sound good to me. Keeping this patch focused makes sense.

Thank you for confirming.


Thanks,
SJ

[...]
