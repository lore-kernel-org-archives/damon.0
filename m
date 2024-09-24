Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0714AEEA
	for <damon@lists.linux.dev>; Tue, 24 Sep 2024 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727200523; cv=none; b=UagHwRCtgz/Y53CTs7G4pDPNiY8miCSD7F2W6/qm5HtxNoi+vA/tnrrJ12EqS3SYOHY4WHXOrgd7BNtueuAVXpZKpZ6AtHAwmIaG+tvSv+dvkUiKJ7WBnmAAiFx0zscKYeusmjEStOBA29CwXwiHZ/ezkwumkZ9sucbYo0MY9Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727200523; c=relaxed/simple;
	bh=QxT914bDA0RfhWDMhfLmy+RtduzqQ8elqZ2JNEBwLdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=miXYLIujX1vGQ6xJLTKCaXplxebRjXa/NWtb93nQKBIlNX5T7zcmet3+xdAtQdKn1U3jZ6LHtogV9ZtM17UbBqNFDMzp5a8NUGbl1UAPdZ/ilGIZB7NqwoQYDpnzjXpr/4dmRqLHm5ts6aaZH8Fkwme24aHlgwMfSF+VoSUUfzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MunJArfi; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MunJArfi"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6de15eefdd3so43262217b3.0
        for <damon@lists.linux.dev>; Tue, 24 Sep 2024 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727200521; x=1727805321; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LhO9HuyHJw2V+eJWsbkCc/m6qGmvadaQTKFPjTTqDRs=;
        b=MunJArficWd/31hxTfcLOLRuQjLQvD7Omx8Sg6oQ5MnfkP9NknMMgu9sk7lsq99Zh8
         WyTfipTH7dRbQ2HQbxNGcDzzter3eGUTDZIhFA8L60/vb8McPuhvpkpCE7CqI0k0j35N
         U5wHZBn6//eXnwfVkTBb1ae6NBR/mwcP3JUvZZU/y1xZkwBD1oWJAN0yCXAtdjl22COf
         9CIWi60RjI9DL+ETMhOxS3rxSX/haJfmfueMFFtRzqpyeHDLdBdNBNszFEgMZPtVouVJ
         7uR4um+ERdn6eW1YAebNB/bfW2iaGir5bQhYq82AAiWOMTSYHjTJUaWbwDZ7H+tCZydE
         3z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727200521; x=1727805321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LhO9HuyHJw2V+eJWsbkCc/m6qGmvadaQTKFPjTTqDRs=;
        b=tQqn4AeifRcmsFy5vVkLquPNAmYRXqOpevoApFJKQPfC7HPyHNHTUEqWtaU6lGW2Da
         FLnph3GDobdT48m8Gef5OhZ0sCNvYktjEl8oTC6BDe6Vsw+HYXMtgYOhN5lk8whT0hGs
         HbV1f5wgxE2OoK33evJSwX0IR1VK1I7tDXNHfqREUKX6scEB6MgK1TfCJMP5ecQzf2fF
         ENgRCzunvJlPRAUzax2/i43GEkNq3lYenSjVQZMZZHeRv6uHmsPCe8GlOC4jNc38uL1D
         7+NmEbogULT2RCESzJQ/cT9L6caxanCpGh6ymyBh9/NZM6yVXZrDsPzObvgFJiYb1+l1
         gvcA==
X-Forwarded-Encrypted: i=1; AJvYcCUYJN95WEb8uqnKJbYQm3TJBkZrpaeEp4eh5wydEk5WwmvpWvBka61/WB0JyjVWNDkBUiDVbw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkUk+p7s3H+8MwYZDNjGGuF9S97RQh4mw88nf4N+R+pLbhVYtC
	DT0r2LOBfBPwQRGqC317r+b1cdgav81mNIiJ7IWUuSVqF3riN3+y
X-Google-Smtp-Source: AGHT+IGoGHDLRqSqcbdYZpBp/Ik1TaSCEKbTqZMOHeO0TcNrA4v/Gon8yURePwJaL0JDdo0Gddcv6w==
X-Received: by 2002:a05:690c:6d88:b0:6dd:ba68:4bd1 with SMTP id 00721157ae682-6e21d84a573mr3032407b3.21.1727200520967;
        Tue, 24 Sep 2024 10:55:20 -0700 (PDT)
Received: from localhost (57-135-107-183.static4.bluestreamfiber.net. [57.135.107.183])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e21a2224bcsm1077837b3.53.2024.09.24.10.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 10:55:20 -0700 (PDT)
From: David Hunter <david.hunter.linux@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Allison Henderson <allison.henderson@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	damon@lists.linux.dev
Cc: David Hunter <david.hunter.linux@gmail.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	javier.carrasco.cruz@gmail.com
Subject: [PATCH v1 1/1] selftests: set executable bit
Date: Tue, 24 Sep 2024 13:54:57 -0400
Message-ID: <20240924175500.17212-1-david.hunter.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turn on the executable bit for the following script files. These scripts
are set to TEST_PROGS in their respective Makefiles, but currently, when
these tests are run, a warning occurs:

  # Warning: <file> is not executable

Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
---
 tools/testing/selftests/damon/damon_nr_regions.py                 | 0
 tools/testing/selftests/damon/damos_apply_interval.py             | 0
 tools/testing/selftests/damon/damos_quota.py                      | 0
 tools/testing/selftests/damon/damos_quota_goal.py                 | 0
 tools/testing/selftests/damon/damos_tried_regions.py              | 0
 tools/testing/selftests/damon/debugfs_target_ids_pid_leak.sh      | 0
 .../damon/debugfs_target_ids_read_before_terminate_race.sh        | 0
 .../selftests/damon/sysfs_update_schemes_tried_regions_hang.py    | 0
 .../damon/sysfs_update_schemes_tried_regions_wss_estimation.py    | 0
 tools/testing/selftests/net/rds/test.py                           | 0
 10 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/damon/damon_nr_regions.py
 mode change 100644 => 100755 tools/testing/selftests/damon/damos_apply_interval.py
 mode change 100644 => 100755 tools/testing/selftests/damon/damos_quota.py
 mode change 100644 => 100755 tools/testing/selftests/damon/damos_quota_goal.py
 mode change 100644 => 100755 tools/testing/selftests/damon/damos_tried_regions.py
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_target_ids_pid_leak.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
 mode change 100644 => 100755 tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
 mode change 100644 => 100755 tools/testing/selftests/net/rds/test.py

diff --git a/tools/testing/selftests/damon/damon_nr_regions.py b/tools/testing/selftests/damon/damon_nr_regions.py
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/damos_apply_interval.py b/tools/testing/selftests/damon/damos_apply_interval.py
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/damos_quota.py b/tools/testing/selftests/damon/damos_quota.py
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/damos_quota_goal.py b/tools/testing/selftests/damon/damos_quota_goal.py
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/damos_tried_regions.py b/tools/testing/selftests/damon/damos_tried_regions.py
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.sh b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.sh b/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
old mode 100644
new mode 100755
-- 
2.43.0

