Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D5B110D
	for <damon@lists.linux.dev>; Tue, 21 Feb 2023 07:08:45 +0000 (UTC)
Received: by mail-lj1-f177.google.com with SMTP id x41so3462968ljq.13
        for <damon@lists.linux.dev>; Mon, 20 Feb 2023 23:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sW5OTipyHanuMGGEr19+SfAUNI4fh6TQoQ0SKxiVbds=;
        b=xPFad2O3o2T7JjjqimSZr5bDzhsCKNA/ZkT84IvIGWjisfYMVY8ez3JcB+xGEpxfzH
         gzirFObAQN+Ea1riiRgJJHdkV60VszkVhQ5ytQBgoncx5bHNah9foz2MkmgJvH9rJoiN
         d6tn2jmty0h7uLUWzB07Njf46FAaTlNyEzn9BLtanEX3CXGHtAMFNsW1ruwFyhQ+KwDd
         ygE+DhlYQOCkxiy7y5GaQpMsQYTHikXVAIBNl0xtMndF5GNCHqKtF9YGZzi0KBl+t0lG
         bHzSDsMIdnKH9n22w8OfOrLDZgR4nTLts+MKO+3nKWe575Ub2BfB5D+IwyVIcN864IWy
         i/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sW5OTipyHanuMGGEr19+SfAUNI4fh6TQoQ0SKxiVbds=;
        b=IB4ZmgNQ6D2moxezmNHIHW3e9VRYwa6vJpOBVgVUQhxWxDS7tJJwMuGEM+novKnPWn
         KvcYA35+eDoYgaguxnfFb3wuHGmqSgRHx/se7Xuwg5uNfK6eLU5tUeXIxScyg4A79eZB
         BNy/2DuFVZCpyWXxq5mnNZdetvkFt0Og8rzUZTU8bcWWKI3NVhqvFPAiOcu/sBIPOH54
         AqU/9DymMEe1I03FiYi43UlE3gTrQttpe/bxIJAnD/e9HTjwWb71KujU5g/auGV3oR4U
         OW2yXIzC7RaowfwpMXsrgqaGLK5y9fMX2PI+HBaVFGmUE7CYSg6d64PV8Lp5nA2991zE
         lIDA==
X-Gm-Message-State: AO0yUKUENm1s3h8IroiLsbrdXV8Z2O5NFG+VNlDsmBACuKBZT+bnhQOk
	rKfQb3N7c6fpF7GLIk745uBrprzlXFYVAY2dNs4=
X-Google-Smtp-Source: AK7set9MVl9dE0Gqmud9UHGJXFGDa+7JeOO8MZD8yAHqxQi9OKB89/YMGpoENiqGS13QSoc5sBuOfQ==
X-Received: by 2002:a05:651c:1214:b0:293:5359:79e5 with SMTP id i20-20020a05651c121400b00293535979e5mr1539070lja.45.1676963323899;
        Mon, 20 Feb 2023 23:08:43 -0800 (PST)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id v17-20020a2e9611000000b002934ed148afsm1809964ljh.52.2023.02.20.23.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 23:08:43 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: sj@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 2/2] selftests: damon: change scripts to be executable
Date: Tue, 21 Feb 2023 08:08:37 +0100
Message-Id: <20230221070837.1502935-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230221070837.1502935-1-anders.roxell@linaro.org>
References: <20230221070837.1502935-1-anders.roxell@linaro.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running kselftest-damon The following issues shows up:

'# Warning: file debugfs_attrs.sh is not executable'

Changing the scripts so they are executable.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/damon/_chk_dependency.sh                  | 0
 tools/testing/selftests/damon/_debugfs_common.sh                  | 0
 tools/testing/selftests/damon/debugfs_attrs.sh                    | 0
 .../testing/selftests/damon/debugfs_duplicate_context_creation.sh | 0
 tools/testing/selftests/damon/debugfs_empty_targets.sh            | 0
 tools/testing/selftests/damon/debugfs_huge_count_read_write.sh    | 0
 tools/testing/selftests/damon/debugfs_rm_non_contexts.sh          | 0
 tools/testing/selftests/damon/debugfs_schemes.sh                  | 0
 tools/testing/selftests/damon/debugfs_target_ids.sh               | 0
 tools/testing/selftests/damon/lru_sort.sh                         | 0
 tools/testing/selftests/damon/reclaim.sh                          | 0
 tools/testing/selftests/damon/sysfs.sh                            | 0
 tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh  | 0
 13 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/damon/_chk_dependency.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/_debugfs_common.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_attrs.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_empty_targets.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_huge_count_read_write.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_rm_non_contexts.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_schemes.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_target_ids.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/lru_sort.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/reclaim.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/sysfs.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh

diff --git a/tools/testing/selftests/damon/_chk_dependency.sh b/tools/testing/selftests/damon/_chk_dependency.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/_debugfs_common.sh b/tools/testing/selftests/damon/_debugfs_common.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh b/tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_empty_targets.sh b/tools/testing/selftests/damon/debugfs_empty_targets.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_huge_count_read_write.sh b/tools/testing/selftests/damon/debugfs_huge_count_read_write.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_rm_non_contexts.sh b/tools/testing/selftests/damon/debugfs_rm_non_contexts.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_schemes.sh b/tools/testing/selftests/damon/debugfs_schemes.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_target_ids.sh b/tools/testing/selftests/damon/debugfs_target_ids.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/lru_sort.sh b/tools/testing/selftests/damon/lru_sort.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/reclaim.sh b/tools/testing/selftests/damon/reclaim.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh b/tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh
old mode 100644
new mode 100755
-- 
2.39.1

