Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C09298C0B;
	Mon, 12 May 2025 18:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747074443; cv=none; b=QqsKXafzqxgvGBKPaQNmwjXLUM+S3DiL7zRULLPu241nbZzOr9QZoJB0dVph9CzdsP+p0ORHw+WU2kPbAJ6trP+jSCvpIfWVeZYR92Zyr0hpzyz3BbHzz6o+S1rTCfqb9P7HlDGAny0BscyZpogtJt6uifPOFdKCh1BaPLgu3ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747074443; c=relaxed/simple;
	bh=HKQfbgL1YrH2cL7GiSCDUId15vhW8YPQ2YX3lu9rJwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lqVDRywYx6pzRfHys0KD72tkymYbYvDbhyf+Ml9K6ZIoOOmZ9rQdOYLS6/YXDzDYCB8E5dXQhQEJUvK72hJG66mchvSxt043479xaWe6kdUDyUFj8E0oifClzmrkZawMC1S1R3x2jX4wpyV1zOtt02xeE8ZUHFFUUda8Pixl0kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNLRX57s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNLRX57s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7702DC4CEE7;
	Mon, 12 May 2025 18:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747074442;
	bh=HKQfbgL1YrH2cL7GiSCDUId15vhW8YPQ2YX3lu9rJwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QNLRX57sapM4K6twrETGdQ99PMJEYSnWXwllbbkmZ+rWRpKaf6GyF4GPc+dzQiewi
	 N5lkd5rO97NlP0e1AdEnkEFSDX3EQ5od3yOzKHBMwQIlE2sXD9gzYR6fxLYyGVd8cR
	 2fo+ck2qGpmphkmqbgm35ckYyTpi2jxJEHLYED8sj/uP3oXRzBr2Bci0irjsCnMO5J
	 Z23AHIyCv1j+lBQkAVkFCPSBHO3olR+wzgzqxn6xaK1gbdVyiwzX6hqkiY/BAmqYub
	 R8JAJQHzUu9JHEVPHB6X7LU7CESzjfRIgQWughqNh2WOIcZZMV4K0bMRtMSZhF8hxU
	 fyYggR68mGsaQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/2] mm/damon/Kconfig: enable CONFIG_DAMON by default
Date: Mon, 12 May 2025 11:27:16 -0700
Message-Id: <20250512182716.50245-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250512182716.50245-1-sj@kernel.org>
References: <20250512182716.50245-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of this writing, a few major distros including Alma, Amazon, Android,
CentOS, Debian, Fedora, and Oracle are build-enabling DAMON (set
CONFIG_DAMON[1]).  Enabling it by default will help configuration setups
for them and future users easier.

Build-enabling DAMON does not introduce a real risk since it makes no
behavioral change by default.  It requires users to make explicit
requests to do something.  Only one potential risk is making the size of
the kernel a little bit larger.  On a configuration, it increases the
resulting kernel package size by 337,685 bytes, which is about 0.1 % of
the final package file.

Hence, the benefit of enabling CONFIG_DAMON outweighs the potential
risk.  Set CONFIG_DAMON by default.

[1] https://oracle.github.io/kconfigs/?config=UTS_RELEASE&config=DAMON

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index c93d0c56b963..551745df011b 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -4,6 +4,7 @@ menu "Data Access Monitoring"
 
 config DAMON
 	bool "DAMON: Data Access Monitoring Framework"
+	default y
 	help
 	  This builds a framework that allows kernel subsystems to monitor
 	  access frequency of each memory region. The information can be useful
-- 
2.39.5
