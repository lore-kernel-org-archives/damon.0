Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D379881720;
	Mon, 12 May 2025 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747074440; cv=none; b=aESoIPDNrBzri3KfFi5RHUL8g0fEp9mE/bR4/nYBHVAme52TwXqKnmmAvstuqoOPeamEeAmPVYEaxQHkpUWO4/V2mCasp2MUFFHPwbaju2khq8DaOnAmTt0rwMFcsU/2KktCr+Q4RXQPwNlOSCccWSb/u/aGfKyqUrDSsV/Wyz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747074440; c=relaxed/simple;
	bh=vJeFL2hITonOBzERtmPv8mt27uPMiROxNLKSwwV1ZZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YyQO8WzBUz+M8P3dsN2n5k4Ts5q6kzFsuQRoriFdZueets6MRob1HtC9CcpHLJqr3pNviIZHmt/46q2q2B7JGfMEOmh//Hgp5HQYHjqVKpFFOACuuiR2FiK6G3+U90PYaDOx4sNBSR1RR/Zv7eMse3/I6p5FDX/AWdxsoOf4VEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkburK5L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkburK5L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21431C4CEE7;
	Mon, 12 May 2025 18:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747074440;
	bh=vJeFL2hITonOBzERtmPv8mt27uPMiROxNLKSwwV1ZZo=;
	h=From:To:Cc:Subject:Date:From;
	b=NkburK5LfA9tq5Wj7VDYZlKPHKL/T2d7tJewUe6jYkoQay3k/vywbqjq6QyJisElJ
	 oOFE1tOzsEFUdw9XGbqui+TZbSH04PeejJKdV8Wkr6t/NumlC+aLusir+ApCTmfE83
	 1MQiWxbvmuCYE8A3ynSVPCCpByE7h4mro+EZdfkpGQbLa7SZRbEbtO4RhUlq4fmNHH
	 A05j7vFMdJhiPXYKrTQVjXTzQsZ6EqPsFctnfg0j0RscsNnwN6dZ4qyReqRfOOCog6
	 Q8x8ARqBbXycFEy+GTlrx0T08kVJGd5mixKxZtINAK7cXqy3PG2EOKKmesc1clWxFu
	 Ityi0Kgj+5V7g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/2] mm/damon: build-enable essential DAMON components by default
Date: Mon, 12 May 2025 11:27:14 -0700
Message-Id: <20250512182716.50245-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of this writing, a few major distros including Alma, Amazon, Android,
CentOS, Debian, Fedora, and Oracle are build-enabling DAMON (set
CONFIG_DAMON[1]).  Configuring DAMON is not very easy, since it is
disabled by default, and there are multiple essential options that need
to be manually turned on, one by one.  Make it easier, by grouping
essential configurations to be enabled with one selection, and enabling
build of the essential parts of DAMON by default.

Note that build-enabling DAMON does not introduce a real risk, since it
makes no behavioral change by default.  It requires users to make
explicit requests to do something.  Only one potential risk is making
the size of the kernel a little bit larger.  On a configuration, it
increases the resulting kernel package binary size by 337,685 bytes,
which is about 0.1 % of the final package file.

[1] https://oracle.github.io/kconfigs/?config=UTS_RELEASE&config=DAMON

SeongJae Park (2):
  mm/damon/Kconfig: defaults VADDR, PADDR, and SYSFS to DAMON
  mm/damon/Kconfig: enable CONFIG_DAMON by default

 mm/damon/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)


base-commit: 399b2f61ec1add307a04f0d128a3de333c4d1daf
-- 
2.39.5
