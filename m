Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785337C
	for <damon@lists.linux.dev>; Sat, 25 Jun 2022 05:56:40 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id h192so4264840pgc.4
        for <damon@lists.linux.dev>; Fri, 24 Jun 2022 22:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vI5/9tMSai6sEiMDgKYG4Cvt0bVWGX78NMg6buGrxMs=;
        b=Cys8IzXQH2MsSDgOyFJyh/9lRs7A21k6srYNuYr+moHfExJYKc4YcjSS/HGLsodV/X
         S1FA/sgVFnsOOsM0u0eI3sjcC6S8oEc+kmNqh7d5IAp4k5IrsZA1kYWt51VD9dP/vDsK
         gqk6YJI06Nm9hW8YH7Sf9aQUzZ7VwtH5RJ4RMentQgNzpLnEjUkvdJg8IOzVO1DtocvG
         AHgK2mTkIhtLlcZKBAa/58Yz1B7ULNX64b8279Kz08273WgKauMGIMXwWBkyHaZALXtM
         oCUbOHIDA8UPQniqAdH6zBRf5aXRLg23/PJyL5+dQJ5X3foUJ6/ja7AigwNVJP3YqiAU
         0m/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vI5/9tMSai6sEiMDgKYG4Cvt0bVWGX78NMg6buGrxMs=;
        b=HqvkrwKR1TwFxOXP1n4WNBZxdWb3y80QNwTiYJyQpnnTsvoztuWmpOPgkamU0019/n
         blXWrysEayt4dv8B0TAug0eO1m97mf+HGwkEd0/5v8CqVPbQksADYznxf5XIdjG44K5p
         WYAAsUnstJzq6JIgmvT7cHhFDE+momispV1d+WHkaH5n+3Px6XtiOYNc3tGagptH4q7+
         WS9TwofJfqrLcivrfgQiPnB8Qxp5jV6uieSMxadAK/9q29N580dpnTnW/93EPi13r+OS
         m71F93cJJxe/WMNHu5G8gBKBWh4ReKyOK1fOb8ZeGuRK70ACaFLMyTP8/6qxB5EMWgBa
         8N8A==
X-Gm-Message-State: AJIora87mljXKo3dm+S5zeYA6ZsWQM5Zc0uEaTHuFyw9vjEu0qFiJlKW
	TmoH6PFbApnZ9zZvc8K7zm4=
X-Google-Smtp-Source: AGRyM1tKbanRfe8gCWw87yykbSIujh994LuikAhfSQmYN3gdd9dkDRc5leilpUgWiJlPqP+hGlrqlQ==
X-Received: by 2002:a63:a70d:0:b0:40c:a1e3:23c2 with SMTP id d13-20020a63a70d000000b0040ca1e323c2mr2301813pgf.84.1656136599769;
        Fri, 24 Jun 2022 22:56:39 -0700 (PDT)
Received: from fedora.. ([103.230.148.186])
        by smtp.gmail.com with ESMTPSA id x20-20020aa79574000000b0050dc7628183sm2819997pfq.93.2022.06.24.22.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 22:56:39 -0700 (PDT)
From: Gautam <gautammenghani201@gmail.com>
To: sj@kernel.org,
	shuah@kernel.org
Cc: Gautam <gautammenghani201@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] kselftests/damon: add support for cases where debugfs cannot be read
Date: Sat, 25 Jun 2022 11:26:08 +0530
Message-Id: <20220625055608.12812-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220624202921.80867-1-sj@kernel.org>
References: <20220624202921.80867-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel is in lockdown mode when secureboot is enabled and hence
debugfs cannot be used. Add support for this and other general cases 
where debugfs cannot be read and communicate the same to the user before
running tests.

Signed-off-by: Gautam <gautammenghani201@gmail.com>
---
Changes in v2:
1. Modify the error message to account for general cases.
2. Change the return code so that the test is skipped.

 tools/testing/selftests/damon/_chk_dependency.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)
 mode change 100644 => 100755 tools/testing/selftests/damon/_chk_dependency.sh

diff --git a/tools/testing/selftests/damon/_chk_dependency.sh b/tools/testing/selftests/damon/_chk_dependency.sh
old mode 100644
new mode 100755
index 0189db81550b..aae7ff8c2080
--- a/tools/testing/selftests/damon/_chk_dependency.sh
+++ b/tools/testing/selftests/damon/_chk_dependency.sh
@@ -26,3 +26,13 @@ do
 		exit 1
 	fi
 done
+
+secureboot_error="Operation not permitted"
+for f in attrs target_ids monitor_on
+do
+	status=$( cat "$DBGFS/$f" 2>&1 )
+	if [ "${status#*$secureboot_error}" != "$status" ]; then
+		echo "Permission for reading $DBGFS/$f denied; maybe secureboot enabled?"
+		exit $ksft_skip
+	fi
+done
-- 
2.36.1

