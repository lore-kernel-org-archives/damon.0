Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEA038F922
	for <damon@lists.linux.dev>; Sat, 23 May 2026 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779529466; cv=none; b=MsdwehIGtqAyaQhl4lPt4/RH0FKeFUxpcMwgXaHl+0WAu3mD6DIY/9Vw/aqAmo7KrJg4Rmd6f8HD05mA8kFMgxTY6CD4BBuzx8wTgOE05rVNkte9dIRNu2BQVrDybwVARPwFthBraoJRCsv4FLVy0U3Igtv0TpmR5beT4J1XOAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779529466; c=relaxed/simple;
	bh=2X6F7vnlTVLHYY6WdIPCxcHQmhWN0eMKVSV2hTb1Jrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AlQ+90faj36N9Wr9/Wa1htzNqHJq64nZhZ8XtWw7LUR20QovL0SC0DM4LGdw39NXL5ApN0ZGJnDz7ubuImSqzwbVbU9pbHZP/RS2UioWhqZkxayfh3bku7BZBhlaKlpj+rTEXzWChd8v8/LpgkkmGsu/0myXSYi+2FtG0+KvCgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMNt9Fcb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMNt9Fcb"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48fde653997so7042435e9.2
        for <damon@lists.linux.dev>; Sat, 23 May 2026 02:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779529463; x=1780134263; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+33Jnfl9EuHdW/5UYwACzrSC7m7tmZqoG76Vyj9VhpI=;
        b=BMNt9FcbtkfgHpYPdOpQzv6eo1sRu6j4C5eFW5Gu3KgrOkr/eP3yQr19+8yNfvBNAw
         YzDWsfKz0mdjPyAVEH0my/O2yVT0vF6vSdsMpuND4e69gNrSL5K/owMyneugX7iI9W1x
         xNeByIMlvkK7n4j4QbM5E467zqkznM/qYXpMn0S3QxedPRskJlhajmlIjfB4PGs5CbJ0
         mCormGp89K5B0AR5snRtC9uD4/YxP1e7tcvh0pyNztplK6+LVNQvWsx048lBvak6Ekfb
         s5meJ8dU/Vyjn2plGr8RlCrB6IWuSaLR9yvX9A+6F7ei3VuGI0GyD+g4kjKzM48YhLS+
         /BaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779529463; x=1780134263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+33Jnfl9EuHdW/5UYwACzrSC7m7tmZqoG76Vyj9VhpI=;
        b=kpfsprsXmqx9gV4XRyMlQK4PrjhUeJksozRmomUcFv8yUuJI6dsnZhcn6cCUSpKFaU
         x5tId+F5qczwUubxc/hKOw3pTXlGtuKMEGB9Wei5sNW/VspZsUBQ6h5VgnHjh4ggGXd3
         qVb6GZmoJS9szlDq2TpMY+NpkYXPgfMug0/iwgeM5f8fxPYrC6ciH69hkToKqQrFr5KO
         WyYnwgU0IaxebuEjxLq2cnHvj15k/OlsKHBBlDe7aPD/kFPutdnHVN8SFlNTnniLp9q7
         tpzTMah0ZO/wJbZR+r0lW6FZV28VvvAGrVnrLPVisiBLqadExlx9Rr6ChnSvTFhnjNQ6
         CKwA==
X-Forwarded-Encrypted: i=1; AFNElJ8P09HS10alHKRPnOeRXeLKaog6IRbpO/AhxWYLJGQeu5U0sufFapre6IblYmAVM9Ds6XdJug==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywkip00dpJun6lwP50AN6HNTOz9urX/6pPQff3zCfw6vsm744Vu
	LYsrGwwgFd31enIHm0M4o9ncXSq3Fvmwn+rcL6HT/kY7mw0q3tcrkAoZ
X-Gm-Gg: Acq92OEIl7EZ77QuVmBtlI83haHGuTZD31PcvEhIhcWf6iXRKbGW2wpgB2ifc1sLcHS
	VA/IgFQrA9Cyng/BlC3jAfXuoFL55nUcXO/7i15CZuKoPJLWQjc830i9o/utZNQtZpT8BfZ+zaS
	9x80k4iBxU1+ZyreLIjUNsPcfu5vDqW8sOuNRR+iB+TKttp7Hn1aKr031LavdlSxJtGvDrgUGEY
	NdN/0G6OlAhV7P/v4+hvfpnEciS4ZPwHptSXgKOnozxDajB0m2t6FerbdAumdVdEQlU1qk5HbSW
	6V3rZz4bjQQeKxP0jUUopRJYBgCNS2muEsLl4zo+o2GitGemW5SUFkZjX3FCgbEmnmUD8ul33cL
	kb698AzAfPoc7QHxnmQ2ov5jIIw1zRWsITGq1RYHwujX8edBNtDwm2E/GQDHY2+WtZ4sJBZZIC1
	xqRNeKIg3Vd0NzkyU3rOB46Tnmojb5mmOXy7Q7w6FqXOGZb+peQ7cCDwZ8KU6MT/NFEExw4wzxv
	xlAIZI/5TkN90IsuPTKu6oAWSeRSYdqdh1SoQ==
X-Received: by 2002:a05:600c:3e0c:b0:490:4175:4bf4 with SMTP id 5b1f17b1804b1-49042cfe362mr54726165e9.8.1779529463267;
        Sat, 23 May 2026 02:44:23 -0700 (PDT)
Received: from doehyun-dev.pradel.rg.cispa.de (x06.xlate.fw.cispa.de. [195.37.157.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d48e23sm10387044f8f.20.2026.05.23.02.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 02:44:22 -0700 (PDT)
From: Doehyun Baek <doehyunbaek@gmail.com>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Hu Haowen <2023002089@link.tyut.edu.cn>
Cc: Dongliang Mu <dzm91@hust.edu.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	SeongJae Park <sj@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	Doehyun Baek <doehyunbaek@gmail.com>
Subject: [PATCH 0/2] docs/zh: update DAMON usage sysfs documentation
Date: Sat, 23 May 2026 09:44:17 +0000
Message-ID: <20260523094420.741003-1-doehyunbaek@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The Simplified and Traditional Chinese DAMON usage translations are
missing selected updates that are already documented in the English file.
As a result, parts of the translated sysfs hierarchy and descriptions are
stale, and the translations also lack the newer introduction of DAMON's
special-purpose modules.

The gaps correspond to the following English documentation commits:

  commit a7bb1e754559 ("Docs/admin-guide/mm/damon/usage: document 'nid' file")
  commit e85e965bdbec ("Docs/admin-guide/mm/damon/usage: document refresh_ms file")
  commit e0c725455fd5 ("Docs/admin-guide/mm/damon/usage: document addr_unit file")
  commit e06469cdf1fd ("Docs/admin-guide/mm/damon/usage: document obsolete_target file")
  commit 2584dd7496c5 ("Docs/admin-guide/mm/damon/usage: update for max_nr_snapshots")
  commit 652fd06d20da ("Docs/admin-guide/mm/damon/usage: update stats update process for refresh_ms")
  commit e7df7a0bfc90 ("Docs/admin-guide/mm/damon/usage: introduce DAMON modules at the beginning")
  commit d9cfe515d36e ("Docs/admin-guide/mm/damon/usage: document goal_tuner sysfs file")

Update both translations only for those stale DAMON usage entries,
including refresh_ms, addr_unit, obsolete_target, goal_tuner, nid, and
max_nr_snapshots.

Doehyun Baek (2):
  docs/zh_CN: update DAMON usage sysfs documentation
  docs/zh_TW: update DAMON usage sysfs documentation

 .../zh_CN/admin-guide/mm/damon/usage.rst      | 56 +++++++++++++------
 .../zh_TW/admin-guide/mm/damon/usage.rst      | 56 +++++++++++++------
 2 files changed, 80 insertions(+), 32 deletions(-)


base-commit: 79bd2dded182b1d458b18e62684b7f82ffc682e5
-- 
2.43.0

