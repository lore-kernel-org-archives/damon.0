Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C8822D7B9;
	Thu,  2 Jul 2026 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011185; cv=none; b=VtMOu755l1FaoRgKK3IsXyYGfXohkqT6hOLkxTwn5kxblBE5qRxkHjoFkiB0LfYubXcMUPrDTNekEKAYgzi4+cyubomzUhEpqCqX4YeFSxj6TZpnW8qmSriRXY3UNbGZw7JlOqYdcTDLOA/wBAdHYZMhl3LWySMycHe73qbVC4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011185; c=relaxed/simple;
	bh=+SUPM17FyMkhdBqg05UJ5LJlBm3JZwNw8h+Mib6SGa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djLNs5CWdTJwJtY0V4fZwxSkBO+Tkq3mOidLtogl3K0b8X8nywAh2eXVzCdm1KNl6fiYOnqhForifQErns8YNjBRxls+DHsPdS84PKXAy4wgQyy/QOgEjRmDL8O79ForHGP1XWnsmvH3mNkL+CpRqtNPymfQ1VRa5EZuZ8LUtuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Big/Uh5x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Big/Uh5x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FC41F000E9;
	Thu,  2 Jul 2026 16:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783011184;
	bh=AdFubk+JD40bWGnDszpUR8QtopM4gDG6s4W5ZjSbVSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Big/Uh5x+p9UFUyrs0H+TX8SkxXowLs9309ENEt2bZHNEFPVeSIvL00bHj+6bpm/y
	 s8udHbi4jszqqgXKeOlXpUA7KzmEVpFSNVFpyyDq6Q2tuQAlNTHZgadeL2wS+BpmDr
	 6duTpmSGL4zT1r1ioPN028UWP/YtE5PatvwARH4Ev47D7gXUxGX5zO/VlTN87FBAj4
	 1G3pLC0fuQw3cvxZISOhdXlr6cOuusPnuh2jpCqFPzERMGSM8ehDyvqT4qLyVPPXYT
	 mvmg6zxqVvnS0/yc+YD9yAa6o+SLV0TJiBWDgaGH2m4YDAPlF5N6U0oQT202lLwHRc
	 amVrZi3QepJIw==
From: SJ Park <sj@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Lian Wang <lianux.mm@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	daichaobing@sangfor.com.cn,
	kunwu.chan@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v2 0/5] mm/damon: add mTHP collapse and split actions
Date: Thu,  2 Jul 2026 09:52:34 -0700
Message-ID: <20260702165235.86684-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <akY6ZzPnwk-CToMp@lucifer>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2 Jul 2026 11:23:55 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:

> +cc all those you missed.

Thank you for doing this, Lorenzo.

> 
> I really need to write a bot to do this, because I'm getting a little tired of
> pointing this out :))

Good idea.  I will also consider implementing this kind of checks to to my lzy
tool box [1] or hkml [2].

> 
> On Thu, Jul 02, 2026 at 05:46:28PM +0800, Lian Wang wrote:
> >  include/linux/damon.h      |  10 +++
> >  include/linux/khugepaged.h |   9 +++
> >  mm/damon/core.c            |   2 +
> >  mm/damon/sysfs-schemes.c   |  77 ++++++++++++++++++++++
> >  mm/damon/vaddr.c           | 128 +++++++++++++++++++++++++++++++++++++
> >  mm/khugepaged.c            |  46 +++++++++++++
> >  6 files changed, 272 insertions(+)
> 
> You are doing damon changes, and that belongs to SJ, sure.
> 
> But you're also changing core THP code? Please ensure you cc- THP people because
> without our approval this cannot be merged:

Thank you for calling out this, Lorenzo.

Lian, please do as Lorenzo kindly asked, from the next revision.  You don't
need to add those recipients to all the patches if you worry their inbox
volumes.  But do ensure adding them to at least patches that modifies
khugepaged.h and khugepaged.c, and the cover letter.

If it is cumbersome, consider using 'hkml patch format' [3].  It does that (run
get_maintainer.pl and add recipients to each patch and the coverletter) for its
users.

[1] https://github.com/sjp38/lazybox
[2] https://github.com/sjp38/hackermail
[3] https://github.com/sjp38/hackermail/blob/master/USAGE.md#formatting-patches


Thanks,
SJ

[...]
