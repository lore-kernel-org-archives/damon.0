Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8509729A3
	for <damon@lists.linux.dev>; Sat, 25 Jun 2022 19:52:57 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id go6so5783301pjb.0
        for <damon@lists.linux.dev>; Sat, 25 Jun 2022 12:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LBICSrZ7ZTWE0aGK5zqnffAevM2FyYaErZq8jVNzZXA=;
        b=QMQzLC22KyQXzmmmmZz6u5dIeDl23a/ENie1aFh9995ukEC0MzKuKszLQl+8mcAwh7
         YPKbC09oROeAK125AYXWnHmXsgWRoXfx+hOnTgmX8IlzsG8fzyxSysbZDzzzIi7PNqlE
         ZMtA6mW04ey2gLGM024Tb1B3yrV0jH6nb1RWXbSzfyPvEN7V2fkwrVYgLJk82PjCmMSe
         fynTwVvBKtSrzi+F4ReP+VRyL1jzCvXsVAPVWKBkPB/nJskPURhNwm+WaM3WuhXNfECo
         M/PaGWCraxwncSPxHxZyoFxMQ0wpSdqvjl27d7uUiF3ZZHK0dh5oEHkOpuNkhzzjRdYa
         +u/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LBICSrZ7ZTWE0aGK5zqnffAevM2FyYaErZq8jVNzZXA=;
        b=efcGtrI8Mh+cuWxkwNItqHyoDQXVaBDk1eonHKBp9leBNi8HVztFenGw16m21jvLA6
         rZ1HFwuPZRMY9LxVddxVyLcm6YoJW8O0TGhyhf/+X0PAijFyJziTQAGYemdMRUsT2c4X
         0mUi2nRKfJMMSn3rkiuE/BW32Uwna76JoRaYRS1YwfLHGf1yt9CoOzo4s7LCxSFchbBW
         df+Zo2CNWBiDbGyVgmBrak6T2agnUm7dsaXwXQ9TacFfqsdiry/66FbBhoGICA5VU7aN
         h/aj5U0HMnF718WGD2wgUC52/vhAiL5f2Y5Xyz2J+DwqXiwKj+CyDeK1U5fK/fzNw/D/
         xeJA==
X-Gm-Message-State: AJIora++XxlIPYVESUdjpCmHsyEdikDNGSP5se2JMXXD9u9ib38iGE4p
	dBD1X1aaAyB8nsPAhO/n4RlVNBAdLHmHTble
X-Google-Smtp-Source: AGRyM1syOXb9wi5OVYdsvYAFPIYyai2W+N5NrJh+uFS3ivN1hfO6l7MW6BEDR/COeMHTur99obiNcQ==
X-Received: by 2002:a17:902:b083:b0:16a:2ce3:ffe6 with SMTP id p3-20020a170902b08300b0016a2ce3ffe6mr5703160plr.151.1656186776808;
        Sat, 25 Jun 2022 12:52:56 -0700 (PDT)
Received: from fedora.. ([2409:4042:261d:8029:35f0:415b:b9b4:3fcb])
        by smtp.gmail.com with ESMTPSA id c12-20020a624e0c000000b005258df61ceesm1335163pfb.90.2022.06.25.12.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 12:52:55 -0700 (PDT)
From: Gautam <gautammenghani201@gmail.com>
To: sj@kernel.org,
	shuah@kernel.org
Cc: Gautam <gautammenghani201@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] kselftests/damon: add support for cases where debugfs cannot be read
Date: Sun, 26 Jun 2022 01:22:45 +0530
Message-Id: <20220625195245.4368-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220625185501.85168-1-sj@kernel.org>
References: <20220625185501.85168-1-sj@kernel.org>
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

Changes in v4:
1. Correct the mode of the source file.

 tools/testing/selftests/damon/_chk_dependency.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/damon/_chk_dependency.sh b/tools/testing/selftests/damon/_chk_dependency.sh
index 0189db81550b..0328ac0b5a5e 100644
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

