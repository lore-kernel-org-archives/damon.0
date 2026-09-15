Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE32457E47;
	Tue, 15 Sep 2026 23:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789516192; cv=none; b=CPwX5OiWsMsYsq6CG0CUFIbJUu4WsGdB9u95oVOkcXpktLzgIRxGxdQzddh/Zt4bgRypgu9PMieG9zxPn4fOfTGwBM2igc/8Yg4xdHG2VBYD+L1KGSQ28vBr/WQcDV8IXFD6+1ZpZQxysqh338mf2uPRWYfbA+aDG7fcGDRYenQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789516192; c=relaxed/simple;
	bh=MruNz6SkLIuD3dVyTIrnmTDONKX0EZNOfWCcqOrnr+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdFmG5uzy1/Xgb7x27rTRTptwcKjIrJ+SMTURH9Hr+HeJDhQgMMAEMDvgp7HtOa54WuDhVrGWWSnQ+qZSo02LW0QUL5Yj0YraaX2IkS+yaZ7j9hjLCdWuPrt9DKLte6aJIxnULNgNVyQ3vrDhVlt1pP0QKRMLHrFKd4fJQRgH/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R37/l7MY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R37/l7MY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE551F000FF;
	Tue, 15 Sep 2026 23:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789516186;
	bh=wfsqsA42RTLaHAcEouHB0BdpY6IKOeqMBzzSUc5mNWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R37/l7MYIzsZWvs5bZA4sl2BNGKXaeQTUKIkLpnn4ERbwxLWzRGTp42Lb49HJVLOZ
	 fL/IWFbPUll5P8RPuLLKKdJsieaNIvHIcM88ihHRTbiehVsx+0TIuFSwwXH2nZ1Z/h
	 WYqTy49GZ1Wc9VebvC3D3CLEsoI8gHOm/er7yzjX7qdQiWoZ4633W0vSIKotxr3Eeu
	 V+s8vWfD3KA6XnS0C+e+qSli92CS7cUQwWv4JRf6FXvEbxSrtFbpCScZp2999cHcbG
	 qntq+e82CwPXl30d/H4odHWaEruwXvx/Hn2OPgkkxb6Rx68+RT2IhpQG89kGgGC2cF
	 NAu0dogVEyUvg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/8] mm/damon: introduce hugepage_size probe filter
Date: Tue, 15 Sep 2026 16:49:38 -0700
Message-ID: <20260915234938.98475-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915163928.9d6260f445d895429d115fd8@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 15 Sep 2026 16:39:28 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 15 Sep 2026 07:33:49 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > Knowing whether a given memory is backed by a hugepage of specific size
> > is useful for efficient utilization of hugepages.  For easy monitoring
> > of the information, introduce a new data attribute probe filter type,
> > hugepage_size.  It works similar to the DAMOS filter of the same name.
> > It works for memory that is backed by a hugepage of a given size range.
> > 
> > Patch 1 introduces the new probe filter type to DAMON API and extends
> > related data structures.  Patch 2 updates probe filter commit logic to
> > handle the size range.  Patch 3 Updates the filtering logic to support
> > the new type.  Patch 4 adds new DAMON sysfs files for the size range.
> > Patch 5 updates DAMON sysfs interface to fully support the new filter
> > type.  Patches 6-8 updates design, usage and ABI documents for the new
> > feature.
> 
> All queued up, thanks.  With a -fix for [7/8].
> 
> > Test
> 
> fyi, I'm always reluctant to include testing info in the permanent
> record.  Because it's development-time info which becomes obsolete very
> quickly.
> 
> It isn't useful to someone who is reading the changelog in mainline in
> 2028 (or even Nov 2026) because the patchset will have had far more testing
> since these words were written.
> 
> It is of course very useful info but I suggest it be maintained below
> the "---", where all short-term development-time info is best
> maintained.

Agreed.  I will do so for individual patches.  For cover letters that don't
have the "---" lines, I will add an informal note saying "please do not add
below to the commit message".  If you prefer, I could add "---" line on the
cover letter instead of the informal note.  Or, I could add the informal note
below the manual "---" line, too.  Let me know if you prefer that.


Thanks,
SJ
