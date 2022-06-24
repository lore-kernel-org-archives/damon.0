Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D172946A2
	for <damon@lists.linux.dev>; Fri, 24 Jun 2022 19:52:57 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so6712360pjl.5
        for <damon@lists.linux.dev>; Fri, 24 Jun 2022 12:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F64miWX8OIqGg7SQtGzniGR3amqV7Fg7vGx9jO7hUCs=;
        b=KG3QkLlWUxzLyv8sJMKH921oVvgVk521YHQekwTUWlGSfDMB9pqY0/y10mxQ5RC/sE
         RACAUQBOb9GFJAD0pNe7zYYb0zT6qdwrMkun4xBAmlAVFUVejeIgPtfkImyTxDcK9joG
         WIyobwYTQFAzSCctv50iKXFyYvsWZ2NtQoaZp2XypkYmBi9vCH3bCMzGO1zf9oFrsiaA
         m0sLaImwJ8X3u0ZEBoVB33JOBGWULVChZZaKNosHVhxAR7tgzzxUQiCZEi2cfOGxe8Og
         JDxEJb/8Q/5s9D41e0wWDLUquxLYba8LZ/0lPR1GoAoRRWGvZ2yuwD1MOHsJbJVbszia
         ueKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F64miWX8OIqGg7SQtGzniGR3amqV7Fg7vGx9jO7hUCs=;
        b=O1Ygz8KHsJwdnEpJ8nW9j91NENe9PRPmlBa6Jn6D7XKTMyiKaUBPPwvmXr3Z8C0MOO
         XU7lTYaYlN1q4T1KpO+gfECZqsUDUKzK8pJwaqNwhNF10bYg+oAe6Uq1GAsp0rmDtevD
         IpdudPMmteM8MB41+SmOMRJaNmnerJBz0i9l44Cf5llQUI61jSXiz1UIIPdT9JllW8ER
         1uwEmx2kjpIew6Ae5SztyIhsbGmmZX6foHhXfnmF/OBMrbMhlgkzM/LJzC2ABooBRAGq
         J7CJfHW4eiW7saf2Ojkg5NDH9IO4ZM4ZgYnx411ughcDvbqn7VTcR/Yajev+4sfTSWo5
         xXqg==
X-Gm-Message-State: AJIora8JjPFyeY10+yz+nTjCKTEZQ6Pzp48fg7ftw0m8eBaO7pyEMI0S
	8CjW/i246cwomfewqRsCIY0=
X-Google-Smtp-Source: AGRyM1u5oABiaQ4N9vv8eRRoGYjSna+gp2MU2xgiqmbWPGR0eG0IzoEqq8qbimjBVbruzHb8HViHyQ==
X-Received: by 2002:a17:90a:8041:b0:1ec:9f10:3c4e with SMTP id e1-20020a17090a804100b001ec9f103c4emr614193pjw.148.1656100377092;
        Fri, 24 Jun 2022 12:52:57 -0700 (PDT)
Received: from fedora.. ([103.230.148.187])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f70900b001663cf001besm2186069plo.174.2022.06.24.12.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 12:52:56 -0700 (PDT)
From: Gautam <gautammenghani201@gmail.com>
To: sj@kernel.org,
	shuah@kernel.org
Cc: Gautam <gautammenghani201@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kselftests/damon: add support for checking secureboot status
Date: Sat, 25 Jun 2022 01:22:39 +0530
Message-Id: <20220624195239.7293-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel is in lockdown mode when secureboot is enabled and hence
debugfs cannot be used. But the error printed after running tests does
not indicate this currently:

>TAP version 13
>1..6
># selftests: damon: debugfs_attrs.sh
># cat: /sys/kernel/debug/damon/monitor_on: Operation not permitted
># _debugfs_common.sh: line 48: [: =: unary operator expected
># cat: /sys/kernel/debug/damon/attrs: Operation not permitted
># _debugfs_common.sh: line 11: /sys/kernel/debug/damon/attrs: Operation 
> not permitted
># writing 1 2 3 4 5 to /sys/kernel/debug/damon/attrs doesn't return 0
># expected because: valid input
># _debugfs_common.sh: line 16: /sys/kernel/debug/damon/attrs: Operation 
> not permitted
>not ok 1 selftests: damon: debugfs_attrs.sh # exit=1


After adding the check for secureboot, the output is as follows:

>TAP version 13
>1..6
># selftests: damon: debugfs_attrs.sh
># debugfs cannot work with secureboot enabled
>not ok 1 selftests: damon: debugfs_attrs.sh # exit=1


Signed-off-by: Gautam <gautammenghani201@gmail.com>
---
 tools/testing/selftests/damon/_chk_dependency.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)
 mode change 100644 => 100755 tools/testing/selftests/damon/_chk_dependency.sh

diff --git a/tools/testing/selftests/damon/_chk_dependency.sh b/tools/testing/selftests/damon/_chk_dependency.sh
old mode 100644
new mode 100755
index 0189db81550b..6e45c1fe230e
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
+		echo "debugfs cannot work with secureboot enabled"
+		exit 1
+	fi
+done
-- 
2.36.1

