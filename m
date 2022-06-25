Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B715015B3
	for <damon@lists.linux.dev>; Sat, 25 Jun 2022 08:35:31 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso7781051pjn.2
        for <damon@lists.linux.dev>; Sat, 25 Jun 2022 01:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PfI+U63NZLKVZ09V6Z9oBSRXc7vElcpXav+bJvvH+hE=;
        b=NK1Y3X8cC4gG+cYt/V1M/IQ1qELujDa/yKcLRCQm1XvRN/dDddHXQnB9Q38Z6eagL7
         jsEqP/2Yl/2b0u3vGXxRPbKF2XcgQj2bBjd+q13wc2YsFG69UPlcqJv6KyMNz79X0tS3
         pcIutKsNc/MjEgLHMS1kku48nABf9N9woifiuVGJAm83gO2LZg8HVIC0LviDUby/onai
         LqCOsdxDbkpAdWJVaH+ej+lO4OLHJCI75qoagYOoZ2AzzfCJoowoCZSGoPTb0uUCNpwn
         quH9XA0vtcpXV/tdfzmKuaaa7lMQBdMfXKlfvqsu4MipPIik4qDHb43cxyyt4p2tgHv8
         mygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PfI+U63NZLKVZ09V6Z9oBSRXc7vElcpXav+bJvvH+hE=;
        b=IW2zC7kJ+g4fOunk3tVgX2nSH+gzyK3EW68f/pQrHXvCQnuf0EymKYSujsrdZFDpiz
         ejxUiTthNeYScanm2Qoewli39BsjSROYoKdSn8cWnN46Hu/4OaF/Y6db49dA73RawAGq
         b+BFqaXqdt2i2Orxe6C55pycLQh6QT9PBOhmtg4l3GWLzWAWIlWlTJPOV/6C5h/sri6y
         V3kxUL3YoiGBLU3/efbarY9DiWFcE9F6RKyCfdpr1CMnNpyKvANIxVep6bVtJR3Ja6/p
         HnAE1yIrOhVjJ7uEL8vXmZ5ALIiQagr3DCOLeXRZkN85VPywiHT2Nok6EFVSz/8VSc/+
         HRtg==
X-Gm-Message-State: AJIora9axV4jjkFtXL01DxiZID1sQKFoTJAqE81MABGlKs7lsCqtUSHh
	GoMrpWJWrfX9fRhx6FfqrxI=
X-Google-Smtp-Source: AGRyM1s6dsMdYLtWyDA+S3DshJ8D6SZ4TR0+mhVzPUOJgCXEItyndBuPt55lKfMWW+v5UhGxAyTlbQ==
X-Received: by 2002:a17:902:f685:b0:16a:3c40:e3b5 with SMTP id l5-20020a170902f68500b0016a3c40e3b5mr3343349plg.106.1656146131072;
        Sat, 25 Jun 2022 01:35:31 -0700 (PDT)
Received: from fedora.. ([103.230.148.186])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709027c0a00b0016a6caacaefsm2628345pll.103.2022.06.25.01.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 01:35:30 -0700 (PDT)
From: Gautam <gautammenghani201@gmail.com>
To: sj@kernel.org,
	shuah@kernel.org
Cc: Gautam <gautammenghani201@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] kselftests/damon: add support for cases where debugfs cannot be read
Date: Sat, 25 Jun 2022 14:05:13 +0530
Message-Id: <20220625083513.19761-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220625055608.12812-1-gautammenghani201@gmail.com>
References: <20220625055608.12812-1-gautammenghani201@gmail.com>
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

Changes in v3:
1. Change the name of variable holding the error message.

 tools/testing/selftests/damon/_chk_dependency.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)
 mode change 100644 => 100755 tools/testing/selftests/damon/_chk_dependency.sh

diff --git a/tools/testing/selftests/damon/_chk_dependency.sh b/tools/testing/selftests/damon/_chk_dependency.sh
old mode 100644
new mode 100755
index 0189db81550b..0328ac0b5a5e
--- a/tools/testing/selftests/damon/_chk_dependency.sh
+++ b/tools/testing/selftests/damon/_chk_dependency.sh
@@ -26,3 +26,13 @@ do
 		exit 1
 	fi
 done
+
+permission_error="Operation not permitted"
+for f in attrs target_ids monitor_on
+do
+	status=$( cat "$DBGFS/$f" 2>&1 )
+	if [ "${status#*$permission_error}" != "$status" ]; then
+		echo "Permission for reading $DBGFS/$f denied; maybe secureboot enabled?"
+		exit $ksft_skip
+	fi
+done
-- 
2.36.1

