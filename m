Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9797C22D9EB;
	Wed, 21 May 2025 04:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747801680; cv=none; b=efmkL9kKdMTQGVf6X5QJys4ljRflwdbkZCsLmBPaN8aac7PqAIIcw1wmmWwKVDh9wOtOjnrTQAWi0isA16c3ehdUOYWu6rw5gj0TWdn+A5+DJv9Nb54aR14ymGLwGfCv4d8X0o2+KThvYJIK+v/lyJ9cx/YeQReLkxDQXfaZIs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747801680; c=relaxed/simple;
	bh=QSBBOlE6+xkuI/SbTMV1No1TMd5MR84tXspEg2CucsA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iKRtBsOH8mAGLRekMJOzalhDn9NIObEEF2Al+syzlxbMLEY7xjazRUTWZASOxDRyIgxe6+RDIQePtnmwD3vxDaWFNzalDiXh8X0T6kGqv/tz0jnk1f/m0GS7ztc7fDGEhcxZ83L0SyDvVHqXbchs06fQw/7dCjBW5SD4dfccq9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhuHjQIv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhuHjQIv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F37C4CEE4;
	Wed, 21 May 2025 04:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747801680;
	bh=QSBBOlE6+xkuI/SbTMV1No1TMd5MR84tXspEg2CucsA=;
	h=From:To:Cc:Subject:Date:From;
	b=WhuHjQIv6Pol6N/P+dprtI3vKa1js1j6UzApwG/EO+qzN8IfEfogmftX4TbSVuKGR
	 JtEGvyD3Q1aJLwwcQZbWruwk15pkEkLV2792k2hLb2BDKEKKjDbEdU8+ZJCxT57zfj
	 lr8uE13xC/qyMxUs6NRbXDnR/eQvl82NaMwnIeWYQVcCdCyd68rwrtInjFEYQ4jwMw
	 rGeGmllQ2iR2FJLwSXZVByN9hUEoFN9Ww6BjHny4Eet95bIZr1Lh6kdCyfY9FErZWX
	 ppYpXHqasUtTzW97zAO+6ivSL9fnXqRgpe/DLIYZhgRy6lNvPzLFFAer5YAtqYB4ba
	 XwBryLKtDEi9Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/2] mm/damon: build-enable essential DAMON components by default
Date: Tue, 20 May 2025 21:27:53 -0700
Message-Id: <20250521042755.39653-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of this writing, multiple major distros including Alma, Amazon,
Android, CentOS, Debian, Fedora, and Oracle are build-enabling DAMON
(set CONFIG_DAMON[1]).  Configuring DAMON is not very easy, since it is
disabled by default, and there are multiple essential options that need
to be manually turned on, one by one.  Make it easier, by grouping
essential configurations to be enabled with one selection, and enabling
build of the essential parts of DAMON by default.

Note that build-enabling DAMON does not introduce any real risk, since
it makes no behavioral change by default.  It requires explicit user
requests to do anything.  Only one potential risk is making the size of
the kernel a little bit larger.  On a production-purpose configuration,
it increases the resulting kernel package binary size by about 0.1 % of
the final package file.  I believe that's too small to be a real problem
in common setups.

Changes from RFC
(https://lore.kernel.org/20250512182716.50245-1-sj@kernel.org)
- Rebase to latest mm-new
- Wordsmith cover letter and commit messages

[1] https://oracle.github.io/kconfigs/?config=UTS_RELEASE&config=DAMON

SeongJae Park (2):
  mm/damon/Kconfig: set DAMON_{VADDR,PADDR,SYSFS} default to DAMON
  mm/damon/Kconfig: enable CONFIG_DAMON by default

 mm/damon/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)


base-commit: 88d53b68fa80a693259ba705b4750f91e9c77888
-- 
2.39.5
