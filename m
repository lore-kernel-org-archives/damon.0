Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3673131F99E;
	Fri, 10 Jul 2026 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693703; cv=none; b=F/g5up/BuBFRguWyjrldlhqi9l6UxWSMEd6BMH3qb5W2lThhZw0nxqk68uoAQ/KXNDdHvpH36lEkAl3CUQsngk3OZ7wkxcvqT9R9+aUv3warpb5zLsC8BfLcmyT86IE9Pq5gK+IQIt4LmrpKlWHacltAHQ3PytnVkKkGFwUVzyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693703; c=relaxed/simple;
	bh=Lk85H5ywVZmi4uLCTWUufQb/tlfwBJ3hIJkJn0Wy61o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUI3Upo8TKnBBX7RNAh3eRYG7ikchE+80uDB9wKsvgJQm2DKOI8UOKoIhcxoBXiurvzNpfgKelj3LsakZ5bXIg0ZAXNuZAC5LP9cX9fpnpXleG/bfj7XYWR1Wf66w6TfpXb+IPoGYMiqhLp1QdMmCfyNCIzCZzFb+ExaRdAMuP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBbBiWxe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBbBiWxe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEBC1F000E9;
	Fri, 10 Jul 2026 14:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783693701;
	bh=ulN4+TCdNRof1oArK+ARWol5k9fS9quVru4deTo15LQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iBbBiWxeFbpLQIUcTJxY0uAeybSbPWM7G4qbFJjj79p0itLYqGYwSSlPVc2+eJwBK
	 VNoZ/DnTCuJ0ful/dnuuDwqQuhJwX8QFKvArNnEfqem5dSLi0PT/SLyCyr9DTOsH/n
	 iVDKaBNI5Nxd8bQtrgs39I1JksQcPy/33tSvv9PMvbG0WCooCsHRBmGf+LEDbROchG
	 yaEovQmYUBxE3tPrjC5glPrWr/YO/GUQaraCTwvX8ca9/iaZv+qA/Tr4MabSRxByqe
	 7ijkeZUmqAd8WMiUbqx6vgGaKiVBO0Q+Cje6CBbW50H7Mn+Z5RzcDSkOfkFE8JQ7Fg
	 XZlyQdEkJLkYg==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Song Hu <husong@kylinos.cn>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 0/4] Docs/ABI/damon: sysfs ABI document fixes and additions
Date: Fri, 10 Jul 2026 07:28:12 -0700
Message-ID: <20260710142812.25332-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710141631.24657-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 10 Jul 2026 07:16:38 -0700 SJ Park <sj@kernel.org> wrote:

[...]
> On Fri, 10 Jul 2026 12:47:33 +0800 Song Hu <husong@kylinos.cn> wrote:
> 
> > This series fixes typos and fills in missing entries in the DAMON
> > sysfs ABI document (Documentation/ABI/testing/sysfs-kernel-mm-damon).
> > 
> > Patch 1 fixes a path typo, "intrvals_goal" -> "intervals_goal", in
> > four What: entries; the documented path points to a non-existent
> > directory, so it is Cc'ed to stable.
> > 
> > Patch 2 fixes two further typos ("WDate:", "manimum").
> > 
> > Patches 3 and 4 add ABI entries that exist in the kernel and are
> > already described in usage.rst but are missing from the canonical ABI
> > document: the 'update_tuned_intervals' state command (patch 3) and the
> > 'tried_regions/<R>/probes/<P>/hits' file (patch 4).
> 
> Looks good overall.  Patch 3 looks unnecessary, though.  Let me add comments to
> each patch.

Sorry, I was misreading patch 3.  All patches including the third one looks
good to me now.

This series is applied to damon/next [1] tree.  If this series is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
