Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3D130AABE;
	Sun, 17 May 2026 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779040342; cv=none; b=q5/Q6W8PW8KmwKRicMioMkUjLFcI7Yt15ij/pNc7siNBRbl+8wDU3PKZIEI/Jq6NPBWHGdW3UsPHAGnR7FQBRBPopZGARR5ABW+4CBIPvBbcVCSWGgHBrlUP8IKOiGoeG5F0i7+m4sxJdr4ymkqke/ijSidmBOmCOpmv8ZPHcqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779040342; c=relaxed/simple;
	bh=AcuclMGPrrOW6Za7tUM4Up1CwRxD1Fm9/Uh9lY+5/3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcrDT4okHy3aZtPTSrbD8mkPvivvq4le3/CzCFDAgj/2Yl5UeJV9iSbBCwKrM52NCowGtcxh4ocpADQhVIXsbqEBDhj9lWIyxt/HkjPd7iMQVKEKRvAvTLSq955QwlmoOpXhp3X7LRC3Zf/UruDIsezgTpIHg1cmOaVfmaltoqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIXT3IN1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIXT3IN1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA28C2BCB0;
	Sun, 17 May 2026 17:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779040342;
	bh=AcuclMGPrrOW6Za7tUM4Up1CwRxD1Fm9/Uh9lY+5/3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LIXT3IN1LvSWc2kCiJwSKg5zgzy4OE9mn+0aPXI/kO25/LVsh3U+BzDgHDAsRraw+
	 reJ9tgcy0bOkepViNnGLjONy6ujSISAp66gT1J3b/K7laoB4jcLBM1PSS2alfhIDKY
	 89gT2bGzQir9LPwwFXktzT32STfi0cRgQ8u9payWBQNqe3IAZcxu38QZDJexaZdeRs
	 a3/e5F1Ixbbwf2bT/NUT/mfVIwZW7U5GVTwfltTpzbUPM2UdCig0teGjNRpkgThX/A
	 7xPPQJYYG1ZYK6xiVVpDiIL0knUom1eajpcUuQ/Yu0FkZTecvxzQF5plMZOKL1mPd+
	 DapYS2s72ut0w==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 2 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v2] mm/damon/sysfs-schemes: delete tried region in regions_rmdirs()
Date: Sun, 17 May 2026 10:52:17 -0700
Message-ID: <20260517175218.2272-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260517172624.888-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 17 May 2026 10:26:21 -0700 SeongJae Park <sj@kernel.org> wrote:

> DAMON sysfs maintains the DAMOS tried region directory objects via a
> linked list.  When the user requests refresh of the directories, DAMON
> sysfs removes all the region directories first, and then generate
> updated regions directory on the empty space.  The removal function
> (damon_sysfs_scheme_regions_rm_dirs()) only puts the kobj objects.
> Deletion of the container region object from the linked list is done
> inside the kobj release callback function.
> 
> If somehow the callback invocation is delayed, the list will contain
> regions list that gonna be freed.  If the updated region directories
> creation is started in this situation, the list can be corrupted and
> use-after-free can happen.
> 
> Because the kobj objects are managed by only DAMON sysfs, the issue
> cannot happen in normal situation.  But, such delays can be made on
> kernels that built with CONFIG_DEBUG_KOBJECT_RELEASE.  On the kernel,
> the issue can indeed be reproduced like below.
> 
>     # damo start --damos_action stat
>     # cd /sys/kernel/mm/damon/admin/kdamonds/0/
>     # for i in {1..10}; do echo update_schemes_tried_regions > state; done
>     # dmesg | grep underflow
>     [   89.296152] refcount_t: underflow; use-after-free.
> 
> Fix the issue by removing the region object from the list when
> decrementing the reference count.
> 
> Also update damos_sysfs_populate_region_dir() to add the region object
> to the list only after the kobject_init_and_add() is success, so that
> fail of kobject_init_and_add() is not leaving the deallocated object on
> the list.
> 
> The issue was discovered [1] by Sashiko.
> 
> [1] https://lore.kernel.org/20260513011920.119183-1-sj@kernel.org

Sashiko failed reviewing [1] this, due to the not-yet-updsated mm-new tree
baseline problem [2].  I will rebase this to mm-stable and repost.

[1] https://sashiko.dev/#/patchset/20260517172624.888-1-sj%40kernel.org
[2] https://lore.kernel.org/20260514205555.51653-1-sj@kernel.org/


Thanks,
SJ

[...]
