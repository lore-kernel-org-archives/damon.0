Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333E32F24
	for <damon@lists.linux.dev>; Wed, 12 Apr 2023 09:29:11 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id r27so13904980lfe.0
        for <damon@lists.linux.dev>; Wed, 12 Apr 2023 02:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681291749; x=1683883749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rcb/qkDEsQAl3olw9yoUk92A6JDi4rIg7+uNlXHrrCs=;
        b=Alwr349E2yAIHR5wfg8SEgSZr/CCUPuG2GWmqALnr6hK6vdoizML4AWTfimx5up2SW
         cE8J8yP2FMiI6DphLH5GAuGP9jFQhyHr9B9gpzG3o/XOmdzNTJsNKzZ5rhtiPrnMoNN6
         tUkso/4ZDUl4jc01UGsKK7npR707zP10BciQhEVCmXgwtI00WG/ModH5mWWI2Qd3ge23
         eZl6c9m0Ll4esPo6mtIne1N0Vq8tCTxps5632eE7aeNA4kvMdRQaqD56z2m+mnJ5V+Se
         BkbwY8oyLEn7hwSO6+DUHUqZYLNHPwaXJBiwSQp7AkruLSQZxZi+nSJh82LvrlrrozpN
         kReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681291749; x=1683883749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcb/qkDEsQAl3olw9yoUk92A6JDi4rIg7+uNlXHrrCs=;
        b=A/y01SmsByfmI2Z3BYdEsoYDK3BBucNumw1enSpmn2SgtthXm8w1DdLB5SMT+q/gi2
         F+xi0BUqeSUgmLr9gXmSXKv+fHQ9SPVFDCS5I41dwqv1C4YHib/X94JvGUNNJKjybV0s
         5SmJ4qxZO7tcIkGX09QZqjlX3F0KsqJs+gmlryhhYQ+0b59Ce+zaUF2pfGhFdUM1a+fd
         qg8v1/kzb4/EA3sWqt+x7BAlPd0SZOd8I8jyWobSWwNOLTY5p6xvVbK82BXqJ6YAsnY0
         ZM2pjVesrd6ar41fAVxF6jX1pB7UYwyhidkrK1iCKWY1Id4CBO6o+Wsv/cVGzipoULB3
         QG/g==
X-Gm-Message-State: AAQBX9cKGsMo1fYRuSbI510QvrpJvgbOZu8Sq8Z+ebefaDQcxq4KNSC0
	d45xCN/ZOYxh39iiXazBGyD36w==
X-Google-Smtp-Source: AKy350ZowSyMYKkqTf7keNy16KvCpT3A3P84fOVnNItqH3nenGNIhyEzgSn0fOn/v5tDeetQ9TjNjA==
X-Received: by 2002:a19:ad0c:0:b0:4e8:4489:6f06 with SMTP id t12-20020a19ad0c000000b004e844896f06mr3826521lfc.58.1681291749100;
        Wed, 12 Apr 2023 02:29:09 -0700 (PDT)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id i12-20020ac2522c000000b004db3e330dcesm2959121lfl.178.2023.04.12.02.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 02:29:08 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: sj@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCHv2] selftests: damon: add config file
Date: Wed, 12 Apr 2023 11:28:54 +0200
Message-Id: <20230412092854.3306197-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building and running the subsuite 'damon' of kselftest, shows the
following issues:
 selftests: damon: debugfs_attrs.sh
  /sys/kernel/debug/damon not found

By creating a config file enabling DAMON fragments in the
selftests/damon/ directory the tests pass.

Fixes: b348eb7abd09 ("mm/damon: add user space selftests")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/damon/config | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 tools/testing/selftests/damon/config

diff --git a/tools/testing/selftests/damon/config b/tools/testing/selftests/damon/config
new file mode 100644
index 000000000000..0daf38974eb0
--- /dev/null
+++ b/tools/testing/selftests/damon/config
@@ -0,0 +1,7 @@
+CONFIG_DAMON=y
+CONFIG_DAMON_SYSFS=y
+CONFIG_DAMON_DBGFS=y
+CONFIG_DAMON_PADDR=y
+CONFIG_DAMON_VADDR=y
+CONFIG_DAMON_RECLAIM=y
+CONFIG_DAMON_LRU_SORT=y
-- 
2.39.2

