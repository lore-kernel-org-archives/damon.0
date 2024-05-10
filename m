Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F8E4D9E7
	for <damon@lists.linux.dev>; Fri, 10 May 2024 00:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299784; cv=none; b=IoLDoBX5HuQ8KFJYqnABN/skE9gh/la2E3XfiYQcx1+d+LKPHprnf1sBOvr7nO44khwlHtLlBkTYrpbubLfrqdaiscVdRIozaXmBbLMB7LwMOLj7gXWvhI4jrQYBAqgM3wTU7p2trcOC8j/lr/w4pN45iUMGHp35vTFah5BAJDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299784; c=relaxed/simple;
	bh=CSBdvD2frVESGJuxr2TaxNx/hmxxufst4kdYORfDT+M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QL5QHElwbN61C5uyWmL1pGf9QaEt+7GzexLuKBIV4CZV1ISGKiDEhVa0lH3KjF/vt+XSKpwm+07NDJIRNhY/M//9yIy/Yw5xl33rWI59vvDrbMzfW+AVKdrftafQIgP5vjogUJM4lRJpxZ4lQ2jta2ZrPXIjleu/OHkKFtTaK5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QSuWYVv1; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QSuWYVv1"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f472477050so1078361b3a.1
        for <damon@lists.linux.dev>; Thu, 09 May 2024 17:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299779; x=1715904579; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/pfiCQCOCpeS3b+P79XSlfM275G98aKUlpvA+FpfZ7E=;
        b=QSuWYVv1WTOMet7IFG6tgQo9kbgIGb7XRB2DXZSL2A7jKiziNbN0dnNU/WRCty14ul
         dzlEpiiAJa41hi+qLki5b2bo8fsR//nnmUIHVpM6aS09SbbAnvfcuIdW/OQhR9U2qDDG
         +9HoA9iap+fLRHQwPdHjU+Nmsc+lYkL000eKMz7mZj18nk5+vX0RADpRRdn1D7fdvkR0
         MXC0ERCkT60mBP1QXip2dg8kgVh3rscqTdG+HEW7rBHWkKMhjR+2cpautdQcy1MMYGIs
         qe7Hr9aoWDKGTq0YpEuddujsSx5gBpMi2r8CLcoQ0r9XQKkgXOt2iKjzp4/Tcnx0TU0L
         2K8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299779; x=1715904579;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/pfiCQCOCpeS3b+P79XSlfM275G98aKUlpvA+FpfZ7E=;
        b=FbETEcJzncDKsfpwPTcYuMOi4xXsHM50mlwsV0GptKafWq4DRDKsRMgZHIKUfdtcQ5
         X9GwOyvLEOxgmhSpd0JKlBoVLPwdVsNlcz/7z4PTQZ6bDM8TwhjyM45IStE76hPwK9e8
         5DxB4vBuinlDKaRBoVbdtb+HxNX7PZat+aWmfQBZY4pKsoPldzQxkrjQqeankvatcu0A
         1ZwZK/hg/sBkAWiG1aMikaxp1JWojUbY7G6bnWvwuNKe2ciqTeRGz8js6UQD0W4xfkx7
         JMRpS+Lo6Rx8WpZAlW4vei2vJZDlEkWFYrGmvc5dV5QUy0QajMlX9jlZzeZLIb2aJ/+F
         SD7g==
X-Forwarded-Encrypted: i=1; AJvYcCVIsJc/GSmmz54PKuTlrrnkYMGUPw01Z2Bzg9aTiZrUe9XnrvpvuS0y+JmUNXIkA2is020BsG6Sa3TDGvVonMHO4Eho+uQ=
X-Gm-Message-State: AOJu0YyjraDvAGElPbdS6E2Chm2KSiE7Qgr6RmuxQuwFiQNdMkhi3XBR
	z69RO0EWas9//Y107MQkEiJ2XcEMvkpZq1HyIWz9MXoJkNUSyF4I2GwL40BnyHZV1Ac3jKNgRUM
	aVA==
X-Google-Smtp-Source: AGHT+IHa1F5rhkXxvj9b2QgJYJivMxzP9dzNJAuDLYs3QTWopUFJ10s7HO1AbC/fEg0FqzMYeA/jrLgYEm4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:2da8:b0:6f3:ea4b:d232 with SMTP id
 d2e1a72fcca58-6f4e01b953cmr21075b3a.0.1715299778653; Thu, 09 May 2024
 17:09:38 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:28 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-12-edliaw@google.com>
Subject: [PATCH v4 11/66] selftests/damon: Drop define _GNU_SOURCE
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
2.45.0.118.g7fe29c98d7-goog

