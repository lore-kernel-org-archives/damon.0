Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D04110D
	for <damon@lists.linux.dev>; Tue, 21 Feb 2023 07:08:42 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id e9so3256198ljn.9
        for <damon@lists.linux.dev>; Mon, 20 Feb 2023 23:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7e5rBUciBt3LW8lbyzEtnyxGuZZCI/WaI2X5+BKKS4A=;
        b=l8l7bRMadcg9l2ArSXzLPwzQ0O4OM4j/Fv+fr4aTyU0d5+ctRQolIhg9PWy9BbSWjk
         Po8GIZv7b2F7dkbfPNWiAK8kjsn8sGMvCXZ4KcImsld3IUovoVQGeUFC7FTcR7trw0kf
         MwNZLr1tXMCYRO6u+zuuHNosS5TQHAv9dBcwRLctAkH5HzeUyc2s7yR58K0bGxFAg7J3
         Vuj+c7qxUUeWWDEAR+6KvqdBRwTz+8CYNpa3Pnfukc3e9q1tm7IJkMs0uUapPBxQ7tt9
         uttSgk8tswFKDYi0fw4t2u7U2Fyip7v0ifT+Qe97afB0oetBc0NXfFdKmGDk2ooI77Cz
         b6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7e5rBUciBt3LW8lbyzEtnyxGuZZCI/WaI2X5+BKKS4A=;
        b=nQwfMA8G3FHBWRfW44R6qBdba7SPA+hEaPvCA8cEuQP5AvvVIiPmYbvlPd5KPaceUn
         REro+wN9RiXNJ8ka8p8tTeDhBqs5B6GEeqjY+trSITiibGG/Q9ET9TrUetjk2ZU/zzFB
         ZJVeE9Z1Cc2JoWFzreh48Dun2K+ofYfbkJ2FoUH12xV9KHTLVOHQGaFgr9wsHyFnxYXz
         87WdwVddtllgkuVmatz73+etC/3/Fr4RfXzjfQ0HvYhB21UJ9E2/qSVDoMYfNes4slM3
         LL/9ep2unKC568yyWR9CLvgW4X66COpKUUimmyXG+uSWN8KhGH4SeaEQmSK4vBIBZycA
         fDtw==
X-Gm-Message-State: AO0yUKWl2OHGQbDVLZBqeBpp/wTVd64ftc0eoQIqZx2rT/7WdOSDbe7k
	WFrlXOBvLrrVOzvXGk/lIhQsIA==
X-Google-Smtp-Source: AK7set9H9GSv++N7XsxvuS8OmaXXG8SjL8OwuyLnyiWcLajWwzqiPonDZ2+GwrJtlQn/aspD3kAMhg==
X-Received: by 2002:a2e:595:0:b0:294:6cde:b9f3 with SMTP id 143-20020a2e0595000000b002946cdeb9f3mr1868769ljf.37.1676963320543;
        Mon, 20 Feb 2023 23:08:40 -0800 (PST)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id f17-20020a05651c03d100b002946f95b359sm715299ljp.105.2023.02.20.23.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 23:08:39 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: sj@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH 1/2] selftests: damon: add config file
Date: Tue, 21 Feb 2023 08:08:36 +0100
Message-Id: <20230221070837.1502935-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.39.1
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

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/damon/config | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 tools/testing/selftests/damon/config

diff --git a/tools/testing/selftests/damon/config b/tools/testing/selftests/damon/config
new file mode 100644
index 000000000000..a6b636e438b9
--- /dev/null
+++ b/tools/testing/selftests/damon/config
@@ -0,0 +1,8 @@
+CONFIG_DEBUG_SYSFS=y
+CONFIG_DAMON=y
+CONFIG_DAMON_SYSFS=y
+CONFIG_DAMON_DBGFS=y
+CONFIG_DAMON_PADDR=y
+CONFIG_DAMON_VADDR=y
+CONFIG_DAMON_RECLAIM=y
+CONFIG_DAMON_LRU_SORT=y
-- 
2.39.1

