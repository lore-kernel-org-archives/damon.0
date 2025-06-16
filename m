Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129D331A60;
	Mon, 16 Jun 2025 22:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750114111; cv=none; b=bDZGRqa9NzkA9yk+LmJz6jMRhAxyRUT7VKdXZxre64iI7UaM/1yhm/fcuqN5Dj09Hl3hodz+gJNXdrD8c3YUbUjyV1jI54mBmjef6i4m6R90joAGh6u+tqeM4Q3Yq+83SzVa9CXMTwNrko3rvZ0lW2ZduO8oF9c5cfaYTsVnez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750114111; c=relaxed/simple;
	bh=8krNgE0Q5cBmryTO2MlEGaTIpki6xXbb0E3l+b3+r1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XH+lKikqMErSWipuemeGUB9f21SOitp3Bb63khyAvcqZ7UsSjPDtFm2HItAsS7ao2h/zL6EIy71hxDJ5UA/53JPhumvP7SUZFHbbu54cLo+dagFb444E82LaHFym9lLFsGaRlTauT8fAdzbZRHUXNbbBjZSbpQdB2u9fMUHs3GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6+LtIzK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6+LtIzK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BA6C4CEEA;
	Mon, 16 Jun 2025 22:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750114110;
	bh=8krNgE0Q5cBmryTO2MlEGaTIpki6xXbb0E3l+b3+r1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y6+LtIzKEVGGN+1i5W51lzJbfRBFmG4SWPtB75S/A14iwGHX5kIYb6UGmfwIvnmYj
	 v8bo8Ronz8UhU0dmllfHS0G+drLvTwq0LhWRHeTNzfBSoRb3ZEnrzoW1SOLs0e2k3r
	 mugATTfMDuzXu1x2K6nPxiTMqvuEr2qkQk+0kiEzVP/MXPzUZt44zCuxIlzlTIhcFP
	 VbRiHubsEuL5hFkNwBqsMbcvPkjcL5fJ4T/tO+3VyrBrUFBvfSI4BYsMiaBrjsqm13
	 IaUcNKw4sVz4vjYxMFjK5XiqxflY/pDMoDsp8jkhEVYiZiAmGmFR3GFpYxfHGIg0AM
	 fqQcDComO/VDw==
From: SeongJae Park <sj@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/3] mm/damon: use alloc_migrate_target() for DAMOS_MIGRATE_{HOT,COLD}
Date: Mon, 16 Jun 2025 15:48:27 -0700
Message-Id: <20250616224827.3009-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250616213159.2839382-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joshua,

On Mon, 16 Jun 2025 14:31:58 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> On Mon, 16 Jun 2025 10:23:43 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > DAMOS_MIGRATE_{HOT,COLD} implementation resembles that for demotion, and
> > hence the behavior is also similar to that.  But, since those are not
> > only for demotion but general migrations, it would be better to match
> > with that for move_pages() system call.  Make the implementation and the
> > behavior more similar to move_pages() by not setting migration fallback
> > nodes, and using alloc_migration_target() instead of
> > alloc_migrate_folio().
> > 
> > alloc_migrate_folio() was renamed from alloc_demote_folio() and been
> > non-static function, to let DAMOS_MIGRATE_{HOT,COLD} call it.  As
> > alloc_migration_target() is called instead, the renaming and de-static
> > changes are no more required but could only make future code readers be
> > confused.  Revert the changes, too.
> 
> Hi SJ,
> I hope you are doing well!

Thank you, you too! :)

> 
> These changes all look good to me. And I agree that changing the behavior
> to mimic migration as opposed to demotion might be helpful in making
> opportunities for others to use DAMOS as a means to perform other related
> works (like [1]), without having to use a "demotion" mechanism for simply
> moving pages around.
> 
> I do have one question: I'm curious what kinds of changes callers can expect.
> Would I be correct in understanding that this is mostly a semantic change
> (aside from no longer having a fallback nodemask)? Just want to make sure I
> have a correct understanding of your intent was.

You're correct.  This is not changing any DAMON interface, so DAMON API callers
and DAMON ABI users would not need to make any change from their side.

> 
> In the meantime, feel free to add the following to the series:
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Thank you! :)

> 
> Have a great day!


You too!


Thanks,
SJ

[...]
