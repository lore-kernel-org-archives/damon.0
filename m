Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9A23EFD3D;
	Tue,  2 Jun 2026 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410494; cv=none; b=XUi4RqhiFK9d99N4eCz2STnLKkHmcqxBv/Y8+a3mhLEaNFLUFvybsfdgnxRW0nrm7m1MeCeoNtl6ppyXmWSnUVhGi6M0qbl7gPHJAOGgkvSxCRBYCv+lh69Wi1apGbUCZJD7wxJVS2KqcMzaUIjzi3r+NhNgx/bryMc4bErO7as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410494; c=relaxed/simple;
	bh=WbVZqGTcleRMP0wI4Y9SLP0pAODPf+worg+8bH9A3wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/1t9Q8Gr/Ukpm8JLPLJSx0sIARQo33D0yG9o1+YnAxkyqr6kaApDnogDX6cexKOCPgCnKE3bSnsfH8lLIDiFIjQJRw/zPZK8U5h8f8+eY+fl4c9dHJcsmqhOVCmCURs1MWuyvDDlSpVAqVQLR9P6A8scZTvq5MC1s84iLkATKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOkcjPza; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOkcjPza"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641C41F00893;
	Tue,  2 Jun 2026 14:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780410493;
	bh=Oo+68N6geBT8vGZcIMlRx+xhCMSwCViAAY2ZllIiYBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nOkcjPzaeHoRMbQCjzph8NC3yziwgLLzhsx4CYtwnG4nn+w5QEMVZmZVTi7nFTadA
	 fS3Rb1k6a1wEjUUdYYZP/16nvuiCyDwVIT7Y5C4VoRJhq4ZqwOGPQ5ayAJO5WzXFtj
	 FTm2WjTeWuarFPuAwTDmFubHWrqw2aEgM/rXOXVbvZV+3nG8kjw2sbQr3dAqoBpLgZ
	 ORaIsvVKeFHEYwo8gb4dPSxRmbjgruRtreulWf14eptXl4rwGF7Zin+cN7KRr20doS
	 XeMudyC0I4slg+Tnl0U6ryClQL4SIV4Y82UXg3GGpv+Etd7/I7JFec4AZSoFZPwZCI
	 PIR1x1wR/z2Gg==
From: SeongJae Park <sj@kernel.org>
To: Ruslan Valiyev <linuxoid@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/2] selftests/damon: test kdamond refresh_ms
Date: Tue,  2 Jun 2026 07:28:03 -0700
Message-ID: <20260602142804.102210-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260602131217.2210912-1-linuxoid@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  2 Jun 2026 15:12:15 +0200 Ruslan Valiyev <linuxoid@gmail.com> wrote:

> The kdamond 'refresh_ms' sysfs file makes DAMON periodically update its
> read-only sysfs files (DAMOS stats, tuned monitoring intervals and the
> kdamond pid) on its own, so users don't have to write update keywords
> such as 'update_schemes_stats' to the 'state' file.  It has no selftest
> coverage.
> 
> The first patch adds refresh_ms support to the _damon_sysfs.py test
> control module.  The second adds a test that sets refresh_ms and confirms
> a scheme's stats are updated under sysfs without an explicit update
> request; the test skips on kernels that predate the refresh_ms file.
> 
> Tested on current mainline under a DAMON-enabled kernel: the new test
> passes and the existing DAMON selftests show no new failures.

Thank you for this great contribution, Ruslan! :)

All patches look good.  I therefore added this sereis to damon/next [1] tree.
If this series is not added to mm.git in short term (~1 week?), I will ask
mm.git maintainer (Andrew Morton) to pick this.

Andrew might want us to wait until next rc1 release, though, as
apparently now we want to keep more time on stabilizing mm.git for the next
merge window.  Andrew, please let me know if so.

So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
