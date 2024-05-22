Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721C7E575
	for <damon@lists.linux.dev>; Wed, 22 May 2024 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339610; cv=none; b=oVXI22kV8nzETjDsOiB3GIadIDUtRsNvYkYrBdG/tzfq1ODcjmwOM/bYPxqld7k19x/QwYfmAKvlWBQC0UfHc43LI2eiBYYUDgXY3haMzNT6rNLL9XCAZ/z/Fbg/7DolWjf7FoJwFDGIiWN4JHsH0AcWVGd0YiX6bs8CuQCJgHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339610; c=relaxed/simple;
	bh=62O3V38af8AfBVqt/HK7S1eFdYifF40ZLMchODVkB8g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HyvHcxmXFKJNpJfFpJrKCThkEX+968mA3al/OcT8vQ0f7ddLRlwFE6LMJBnX9fT6I00OZxHf98/OAE9AoLUZwr+IcyYhp9Lf7J9bKg34gIdJ0r2cLESri7z/C3Mrz7JzZBycmcFW+RDYU+gEPeAVJWKlwBYGdx0ixoblkcOBUPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PhULvJ8p; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PhULvJ8p"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ba04ab5e2cso6201662a91.1
        for <damon@lists.linux.dev>; Tue, 21 May 2024 18:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339608; x=1716944408; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qBN6dKvcn7a1ilrAwfzcd0ocDzyyL7QD4f+HvB8bOIQ=;
        b=PhULvJ8pi+sRjDgNKjZWw7tHiqITdomHKPNg/2mCe+QyXTF81oiiv/Bh3jtZosaIBm
         gNbgxhEUW/MZf+MTtrOr7Egjk8DTieAsewygj06HGJcEYMgPsAAqO//fhA+2SitNevNr
         YMMVDbP7H/R5JkHXTjCGCipiQJjdB2/5WjjHgCwY2vlV5Pgtx8kLWafbBaW/HlsitWhT
         /td1G5ImiNXaT08ApehK4Zgha2JYrAskQEFPxxocGxxakYi5djpqrHMdWO3KPXpiaeRw
         u9d4IGT2WqYPnj24MwBBirdqsu9iwJ1gdskuv3zwj2IL2pGjIiZVkoqBsx7LpOWR5jH+
         mv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339608; x=1716944408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBN6dKvcn7a1ilrAwfzcd0ocDzyyL7QD4f+HvB8bOIQ=;
        b=HC+CL8+LqGz9EFE/JuBe3geiylQ+mZpkKR10BNC8RGO30chQ969DC7Zbj215NYYyLl
         jbz88q30GnkI8Z+8ea5qzLLSp/fFa6VvBzB3nn0xQ/ANM3jkDC80DSqVLaf0zC7odQAb
         GZKGXuHnsy5CeIuEEgBsEG//SOjwZkEwHL4lUfmJDff6K63hJf1emkyeyypjK2ADO75M
         yghdZFtgO7t53VDH05nQ0qkW1nWighK2V2zY9wddbXJfrujybGRBowGgvX3m6wVLFysC
         jL6HJJe6zhWnTW5MsQkhcbxwSa0acNAUUVPw9BwhxFEEuPONRW84lgIEQP3SJc3ZFimr
         i6IA==
X-Forwarded-Encrypted: i=1; AJvYcCUdEtIWH7UmiwM65TQUBIMSksyUmaHzu9xK7111QWhdqBpUXZEup3pQb4M7BxO4K8KSCKAfo5b/nE+3Z4VXpaF2qOvWSgU=
X-Gm-Message-State: AOJu0YxQXcA2xsGGfBGJWEw/H+LoiCNzPJODl5b57a/HMPSUVfEm80Jl
	DEPEboOqljskMFpUNtVJ3x6GCALG7gol5MNr1h0HCJtGFxEV7IvS4rs+gxWYeTdkSUiV8qCgEQl
	mHw==
X-Google-Smtp-Source: AGHT+IHt7Kr5feX1gdf4rvQKP41zb9M+M6WWZuA6mfud336Es8VWWBsR3GXtiDGmwzCkNXAVdnqYPJZFEdE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:9f8f:b0:2bd:9285:c147 with SMTP id
 98e67ed59e1d1-2bd9f4a593cmr5758a91.5.1716339607777; Tue, 21 May 2024 18:00:07
 -0700 (PDT)
Date: Wed, 22 May 2024 00:56:58 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-13-edliaw@google.com>
Subject: [PATCH v5 12/68] selftests/damon: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	SeongJae Park <sj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, damon@lists.linux.dev, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c     | 2 --
 .../damon/debugfs_target_ids_read_before_terminate_race.c       | 1 -
 2 files changed, 3 deletions(-)

diff --git a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
index 0cc2eef7d142..3f0dd30f61ef 100644
--- a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
+++ b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
@@ -3,8 +3,6 @@
  * Author: SeongJae Park <sj@kernel.org>
  */
 
-#define _GNU_SOURCE
-
 #include <fcntl.h>
 #include <stdbool.h>
 #include <stdint.h>
diff --git a/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c b/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
index b06f52a8ce2d..611396076420 100644
--- a/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
+++ b/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
@@ -2,7 +2,6 @@
 /*
  * Author: SeongJae Park <sj@kernel.org>
  */
-#define _GNU_SOURCE
 
 #include <fcntl.h>
 #include <stdbool.h>
-- 
2.45.1.288.g0e0cd299f1-goog

