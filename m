Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1012B84DEE
	for <damon@lists.linux.dev>; Thu,  9 May 2024 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284888; cv=none; b=e0fNb6yjf6+dw7IqnEwDg9JMAX4dALtPjiurrPlW0ObFF61MLDOLtP7GYfuyOhFXj16sPPnZTeOjnl5Oru8jbi+O3lh6GYT0UanqzWkpKZEK6WxPOPYVcTFWPAEYHYbJPeYL1xubZErmudKq3rPF7zQGgAlgAou+jQ4BGloFJUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284888; c=relaxed/simple;
	bh=H0xNOT4MYx4yQ3KHHxBXKyqMMscf8BIYORk36eDuIO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U2QDgVa4t1YRu8TWryG7+iWk9NRfZVQjQHagtF62PrBULeciNHcCVFgUPdebFs7WbHlmCWQFpWqEXNXslzDxVn4MmxWc8oaGjWJo14lrSfnN1cZuimdrsRvsNfv4j4OGXhe7i36d8hS2AdbRh6+dRflMv3VHvsunKlSl+/pWjM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4qxAdnlb; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4qxAdnlb"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ec6de5fff5so11625185ad.2
        for <damon@lists.linux.dev>; Thu, 09 May 2024 13:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284886; x=1715889686; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Od8ki9QAqD1fUhM/c9ehfUOTPfP0DcxD+whg8mbh4TU=;
        b=4qxAdnlbq9cLKLZIkDnKjBsMvS/659IRJh7BjgFkevHMxXpNxQH4+uAyAz7lJlf9aI
         6UCXf8w8B8F9x3hezbHZ54ndOYg6vDxyPmz0LexqCsOuG31Oeqzz8+NS82q6Z1lNsbee
         lDiDqPCfIJ4+5sdWw7hbECu0AKZwCbclTkJ9P8JoxIq9b+cmChYuA7HqCdNZWtqoW60D
         1/ZJ8BsgoyS/DyUE8RPYoBRNuUahYKtTbw49w9oZUioEC/413Ly4G285mOZ4dahPciPE
         vBnfPrqcBRXB7oTCSfEUPNgGFQfplqN+S03VYjDkHHmgu0e4l+b3ymFyQCGAVBKklrfV
         4cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284886; x=1715889686;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Od8ki9QAqD1fUhM/c9ehfUOTPfP0DcxD+whg8mbh4TU=;
        b=KCqSqEfZSlbDR3YpX3qZPT6R8NR6NRVLkKVtYMd77xdMpTYjZRnAnUqNcTGZQZNhBX
         EkchzR63V4Gwmm2VqdXG6hwotfGdHmJOIDTndwFKKRNyyWYBKjaMxKXLijyYn2BGfkUv
         cOAyJoKs00R/60HqEqdJlqVrXR7TqY8EhN8k5fgzTAI9eZddKtFKGwbq4HJQ7L1G07iK
         UnXEJW0WciH647KgIKE1C1U8i7qamsKctnr+arvqJiyRIbJR0gSnsCvzmaQa2azC32G6
         QZgE/tLTfHF1Ug6WmOWvSzuvnB4PJYJDRAYP+fqla4GDVZ/xS0yMRqe5EO8Nw9ll5v8I
         MzKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZa72sg2X8P7gH9dqjAvxtfiYagxxLL5uVdA8/3frKaM0faAXwWOfaYfvc+y0pCsFQF7Hs82hph02wBXQiSpoc5Wm3NUU=
X-Gm-Message-State: AOJu0YzXYkvHrwrmGwUsZCaRDAPXF0Klw8QyNu4KJ4nCQ4c62lQacIZP
	yl0yeIPR5Tf5Vr1UAU+3k764nts8n1hX94QahqHDcuBG4KEDCrOWcVhzr3XMZSqImIy8+LMfr5V
	vqQ==
X-Google-Smtp-Source: AGHT+IF+9O8AdOrC0sfYwymi9nDgS8P3uCdoKz+tbRqRCiftF6S/rlAyRlPcJO8FmcCJmXEqc5hw6LgYks4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:cecc:b0:1eb:62c6:98b0 with SMTP id
 d9443c01a7336-1ef44049854mr17265ad.11.1715284886040; Thu, 09 May 2024
 13:01:26 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:05 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-14-edliaw@google.com>
Subject: [PATCH v3 13/68] selftests/damon: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	SeongJae Park <sj@kernel.org>, Edward Liaw <edliaw@google.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	damon@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c    | 3 ---
 .../damon/debugfs_target_ids_read_before_terminate_race.c      | 2 --
 2 files changed, 5 deletions(-)

diff --git a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
index 0cc2eef7d142..7a17a03d555c 100644
--- a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
+++ b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
@@ -2,9 +2,6 @@
 /*
  * Author: SeongJae Park <sj@kernel.org>
  */
-
-#define _GNU_SOURCE
-
 #include <fcntl.h>
 #include <stdbool.h>
 #include <stdint.h>
diff --git a/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c b/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
index b06f52a8ce2d..4aeac55ac93e 100644
--- a/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
+++ b/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
@@ -2,8 +2,6 @@
 /*
  * Author: SeongJae Park <sj@kernel.org>
  */
-#define _GNU_SOURCE
-
 #include <fcntl.h>
 #include <stdbool.h>
 #include <stdint.h>
-- 
2.45.0.118.g7fe29c98d7-goog

