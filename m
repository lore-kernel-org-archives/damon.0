Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807357FA
	for <damon@lists.linux.dev>; Mon, 22 Aug 2022 10:56:55 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id w11-20020a17090a380b00b001f73f75a1feso13548578pjb.2
        for <damon@lists.linux.dev>; Mon, 22 Aug 2022 03:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc;
        bh=hUQZ/Tp1Sqyiv6w3yUz+ygSiTM9PrSsj+REeubDk2qE=;
        b=C3HaUGLQY/5xCsQrVkt+OdGw/vWjDEQbsfd0003LDMRZiClk+Q/ID/FH98FpvzpkhW
         YmozuFBomyLxUP7iEui4cprVH2IL/wR6kybEI06V3D+1rKIOvuB2TD1db8RGJWmOn8BO
         Ratq2FuXP5lPY+ygKTFYyzIWy0inHKk727PrNQfDFkKvRBTwLEKbXo+/gn+HMMKgYacO
         rdBCeFi1Bl6PTxOETCCW7oGQBBfh+B+wNCG48TleMWHAtuFuzBf7Vns0E08EYK9wDqPu
         zpaNILIeB1gIwrhs1EoEHnqsdoj9pdDc0wUs235s2eOFfGUM0Jyhgt9dzstb17bArH26
         KoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=hUQZ/Tp1Sqyiv6w3yUz+ygSiTM9PrSsj+REeubDk2qE=;
        b=oiEop6raFfMX9ZO95T6Bf2umHL92lnCwfZ4jB8hmSJB8nzeI3SnpuHfC2LpPGSxbMA
         rysqvpY86vGTWMmUFyWhrZ5XJewI0evBzzrYCp/y8ppFBPfbRb5I0VFD7DgAYwbRllMi
         URDMDzftaO6NLQvueQRZV61CAnSmqXy1nQwjDK3jA4ukVMCI/56LeMDw80eg/keHewZf
         Jin3pPbJW2Ll9ksqbdYhGLyXbWqUj0I0wwT8zrxtSTyrDkiJgfkvUSTMKZiQF+8cqEDQ
         fbDV4eBwZxoleLoMHQpTtpB9W0ASbBOOEIhPqRI4NdDmXMZwI7gurrV/juV2Y4qUGInD
         sTbw==
X-Gm-Message-State: ACgBeo0BDmmF/SfVvVoiV2aV1JUAyqrNGqkMhVMzzdVe0VZAEoJRN61K
	Yc5v2y/bieMKduFTnwH4Y1Zzyvs3Rd81fupl
X-Google-Smtp-Source: AA6agR5CXRqUs3HJRCeXUJI+lLofKDx4VbPUBq2jOgPfCZ7L6aGgxEOblRidGxRmwmFYt28M9X+3mQ==
X-Received: by 2002:a17:902:7005:b0:172:98ef:863c with SMTP id y5-20020a170902700500b0017298ef863cmr19616019plk.131.1661165814407;
        Mon, 22 Aug 2022 03:56:54 -0700 (PDT)
Received: from KASONG-MB0.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id m7-20020a1709026bc700b00172d9f6e22bsm3727399plt.15.2022.08.22.03.56.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 22 Aug 2022 03:56:53 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH] Docs/admin-guide/mm/damon/usage: fix the example code snip
Date: Mon, 22 Aug 2022 18:56:17 +0800
Message-Id: <20220822105617.75524-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

The workflow example code is not working since it got the file names
wrong. So fix this.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 Documentation/admin-guide/mm/damon/usage.rst | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index d52f572a90298..ca91ecc290785 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -50,10 +50,10 @@ For a short example, users can monitor the virtual address space of a given
 workload as below. ::
 
     # cd /sys/kernel/mm/damon/admin/
-    # echo 1 > kdamonds/nr && echo 1 > kdamonds/0/contexts/nr
+    # echo 1 > kdamonds/nr_kdamonds && echo 1 > kdamonds/0/contexts/nr_contexts
     # echo vaddr > kdamonds/0/contexts/0/operations
-    # echo 1 > kdamonds/0/contexts/0/targets/nr
-    # echo $(pidof <workload>) > kdamonds/0/contexts/0/targets/0/pid
+    # echo 1 > kdamonds/0/contexts/0/targets/nr_targets
+    # echo $(pidof <workload>) > kdamonds/0/contexts/0/targets/0/pid_target
     # echo on > kdamonds/0/state
 
 Files Hierarchy
@@ -366,12 +366,12 @@ memory rate becomes larger than 60%, or lower than 30%". ::
     # echo 1 > kdamonds/0/contexts/0/schemes/nr_schemes
     # cd kdamonds/0/contexts/0/schemes/0
     # # set the basic access pattern and the action
-    # echo 4096 > access_patterns/sz/min
-    # echo 8192 > access_patterns/sz/max
-    # echo 0 > access_patterns/nr_accesses/min
-    # echo 5 > access_patterns/nr_accesses/max
-    # echo 10 > access_patterns/age/min
-    # echo 20 > access_patterns/age/max
+    # echo 4096 > access_pattern/sz/min
+    # echo 8192 > access_pattern/sz/max
+    # echo 0 > access_pattern/nr_accesses/min
+    # echo 5 > access_pattern/nr_accesses/max
+    # echo 10 > access_pattern/age/min
+    # echo 20 > access_pattern/age/max
     # echo pageout > action
     # # set quotas
     # echo 10 > quotas/ms
-- 
2.35.2

