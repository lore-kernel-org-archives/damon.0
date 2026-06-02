Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D054B3DE430
	for <damon@lists.linux.dev>; Tue,  2 Jun 2026 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405942; cv=none; b=EgvqRhIqg8MPHJ93EnBOY4j3cCYMQgIAbwRKureThttWyuYI5XV98fWlSchIKIkDTe+R580SXcwf6iFpOyAiI5OtFJQFspXhCSpr3kq2mdhIDkwOVC4V4SyoDKW0rwNKF8aWdnm1mmF3iHWisYN/Lj4vttF1XnI74wPfYxWcmwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405942; c=relaxed/simple;
	bh=lH4adT+KW+NSXkVWtCeyRqT0psLwQ589XQm4UKcrMsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EkUe1yJ05KfKJPUlsGDmy+jFIzW2DmLeHoKktlvAasFN0kC+9vI1YJhIPsHNQGCcUsAq8D9DKdyfrnVh2iUg0yjuAYzlj45v2K7ZXtaNoIcQZYdw/1kgKrfdvdToJp4JQKYbc+vxrAJN11S4XlXmMHlJMOLcb6Tzj0isxXBNASM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsKKONKz; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsKKONKz"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef4223be7so2444064f8f.2
        for <damon@lists.linux.dev>; Tue, 02 Jun 2026 06:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780405939; x=1781010739; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+MaPoAdcJpUD5zXv0uj/EISz2QKWf/USntIRhT5xYGc=;
        b=UsKKONKzKPgHJYKy0yf36Dz3c3eUYCRfk6Kr08A5X0DC3omeY5/EX9MeviYePAAeoM
         NI7JY1M3xNai/E/MaO54viJBnjr7tYvZpOJkwIxQfKvzarv3RinTUQH8SpBELyyZ6Z9L
         sS9FRrxFSjiJSaPf1wZD8twIxPO7yEY1avT/qGsfEIengQQRFlhm6bfwWjA3jzTounWM
         mcgWWE3IRG3F9br8uipT0gBYzGlzyoxdcv5oHrZrkw4jv8dSwsmY2SOaW8ep9YUNchfG
         FTTho2W6mnnD3+Iz7qRi95pcAtGDinZkVLLBg8lWZHDV/ufR/sSrnTsYbjpnst0r9Z/s
         81tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780405939; x=1781010739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MaPoAdcJpUD5zXv0uj/EISz2QKWf/USntIRhT5xYGc=;
        b=s8bGULxPqPh/Buoj37IlYf+yBeimDnTp5+LlUoE+WfF6y7quOXwBb+ZYwHhVPqTagY
         nKWCAaFxZjPhco+ZBUN/Nda9gDIE14Id6lX5eoyMqfJOAv7raL6GOJWiNMXagVk/gvXs
         H0tkcZY4aUYOPj52sxS+lU2UKB5C5nFYci2j9dpADUnYqbrrf0cUWHHoAWjK4PB6Q3RG
         XFpubKdGPNqHQe6iEux6Fht92eTx8BAfrWnxS0hwtfuGDCWDC3GQCaz83n0q0P4hl8ye
         VMQ4ZmVm+lO2k56lE5ahOZq94xtRNHIVd/13hXyob5zpiXkAeA3MtfrOqpXifg8hwYH9
         PePg==
X-Forwarded-Encrypted: i=1; AFNElJ+bGcjEf5kVH/mhFvHlR6JOzx2MQ8hR1uxQjTFn5yiOALig43Iuue37eGzfda+BATqXA6eP5g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9L7CgqqsN9hsJs55AvbU+HJSaUmRtsfPS9wByyVDKkCvC0SpZ
	Wb4Ak7pGSC7HM7RQdf3mJlON+D9YbcXnVSvBXjatE6smKFoY4vXWAAVM
X-Gm-Gg: Acq92OFerrPTLPX/JzryGI369Kjl2GmTDrqJfCBkYb5vMcOrzGOabojLtMSdiPSEslP
	xi3UQx0EZMKGvQaFlX4o7XTCYa4F5SBlWK57OkDqnBtsJb1ty7/fceFbJGeg4K96nJIN+boPfXJ
	BJOML6nFts8WkxpzSw99U4knvowvpGkVqkqsUCEiS9+g28jTmNq7MgFGaXpvm4rKiUUmnBWNoWe
	EN7oBPAMe/bcpG/yEGoYNAoudS13UCqEphOw+uc/ie8BZKBsm241PpMTsxxjKVYbAkCwTZhFNJz
	2Z/zS+7ILc/oqMMFqbAxI8G9fWPi/3lFV7t7nP6f8xtuotn3kh4wrps9Pbn9ZGPPJM5JZ1HhJYm
	ul9fF2lpoka3XGdfXEERuqei1Ap5fv1uAytIZ1eTIkOoRL/OL/lTGIJxlTw60LA15vatR9A7bKJ
	grXX9tqNJq30z0tsYLvMQp8gcZqMH/ZHuZmTEwNAGI4w==
X-Received: by 2002:adf:e008:0:20b0:460:18cb:8f9e with SMTP id ffacd0b85a97d-46018cb95f7mr5518471f8f.12.1780405938958;
        Tue, 02 Jun 2026 06:12:18 -0700 (PDT)
Received: from x1.tail0e71db.ts.net ([46.140.7.198])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34c3081sm33234665f8f.15.2026.06.02.06.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:12:18 -0700 (PDT)
From: Ruslan Valiyev <linuxoid@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxoid@gmail.com
Subject: [PATCH 0/2] selftests/damon: test kdamond refresh_ms
Date: Tue,  2 Jun 2026 15:12:15 +0200
Message-ID: <20260602131217.2210912-1-linuxoid@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kdamond 'refresh_ms' sysfs file makes DAMON periodically update its
read-only sysfs files (DAMOS stats, tuned monitoring intervals and the
kdamond pid) on its own, so users don't have to write update keywords
such as 'update_schemes_stats' to the 'state' file.  It has no selftest
coverage.

The first patch adds refresh_ms support to the _damon_sysfs.py test
control module.  The second adds a test that sets refresh_ms and confirms
a scheme's stats are updated under sysfs without an explicit update
request; the test skips on kernels that predate the refresh_ms file.

Tested on current mainline under a DAMON-enabled kernel: the new test
passes and the existing DAMON selftests show no new failures.

Ruslan Valiyev (2):
  selftests/damon/_damon_sysfs: support kdamond refresh_ms
  selftests/damon/sysfs_refresh: test kdamond refresh_ms

 tools/testing/selftests/damon/Makefile        |  1 +
 tools/testing/selftests/damon/_damon_sysfs.py |  9 ++-
 .../testing/selftests/damon/sysfs_refresh.py  | 75 +++++++++++++++++++
 3 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/damon/sysfs_refresh.py


base-commit: 174914ea551314c52a61713b9c4bde9e42d48073
-- 
2.43.0

