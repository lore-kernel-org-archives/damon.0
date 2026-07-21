Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329DB46DFF5
	for <damon@lists.linux.dev>; Tue, 21 Jul 2026 19:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660658; cv=none; b=NC5CWv7ObKTjldWg4UUaJac30i+/lKB2jOY9iOvpa4m6C1uvo1NB+z4S2cU4tQ+TzfJKeDagR258fk+QmFaOIGNQed/+ZJVz9bGW7O6QyDcyFa2iJNjYcVRoGJ0RXxszXk+PwoQSj50nnClzx0jW3v4rqsKsEDRxyy0HfLWDp2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660658; c=relaxed/simple;
	bh=Z4eZUu12mKAhhr7fFGJH/XFiozz/hMXcfASu5IYDxqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MLM/uvPAbMt6/qthi139vqHTtp5k/AVfInQspfEY4/YhzNEWAskNo4NsxSFOrCKuUikmt52TLqtFuZ7NOQ8FsoeYQ68ySLCSXr0KC5aIOAynv3iQ3Aj9i0Po7d4A5VXjB/QJu3cEKJDycLh8R6F9iRSRwW59/lm0DolbC1oxO2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNqi0nhZ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNqi0nhZ"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-698beff7178so11240806a12.3
        for <damon@lists.linux.dev>; Tue, 21 Jul 2026 12:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784660655; x=1785265455; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+JqNpnriZg+duzi2qkjlrmcfUYuT9EqwRHf7/xL8TkI=;
        b=CNqi0nhZd8iOMUYkVTA2fQm/0a3CPqHAbo6bRNP8CeWXMPo57u87qntd+VUImhx+UG
         In4BPlkYfU6Yo7Kozp+n3/4Lkd2XytFlhJiMCd2KxDUFjbqx0mur5OWMdkH1HiSYo8cO
         cLUTWN4COpXPuLJIbX13yVYQo7BVswflFsDWVFyr7NPn3zmbfyjFtmOCWfpn2kDr592b
         HA1Qfs08GLWGkKP2/SBV4D1jqTUYacqEyC6EmbvsKXlp0RFHm4iRhdt2rOLdWX6UKzlu
         8ue7pCn7a67EgMNZ/bkOGrhACPSxZ2vUVokSRtNl5haajBOPFnwf6yyLeJBW4u4HGpW/
         26Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784660655; x=1785265455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+JqNpnriZg+duzi2qkjlrmcfUYuT9EqwRHf7/xL8TkI=;
        b=B1JBDZU+twNtgTrDkvI6kNU5MGNjvUlW3t5I8imfbU9jPqf264gayel5dhlQprmHvZ
         54rRzt1LLJEZMY2X1a47CFSluTT2l5etnE+If7qVi+0NkJZ7ym9/k7TO6Uw7JjaBNWIo
         B1mY45sfz3vC5R2iJ7m0bgs9VjM8UEaaXuJXUkIHm7QhIiLgNqFJYRfm1kPdRMka2hqU
         Tmsie80AymIJF3uUgTrGB1JN7k41tMghxgjjEnXHR70JCqJOJ3YjgR0zeGJzJHPY3Brv
         /kyd1z5RdqrESIDT5tQ8IOGIfeV+QyYNTaqRfOY7D4hR7uG5gyuaqqmag6FYsBpCkAr3
         McBw==
X-Forwarded-Encrypted: i=1; AHgh+Rpx6Siy3HnHh02MOLyddrZFW04N+v222ZyUtGiOkTVLqiqMJDMZwX2ha5eDty3SEIUJkoh2xA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKE9NHm3oWgaqumNCSNBxKYa4HVQ7eJUXX0tx5ju+UJS8MjlWF
	nhb71hLihqQHHMnzvzOGuKW134JVeKzFFq8HY2ZD9dhtxHQ8KSLYlCqZ
X-Gm-Gg: AR+sD12L120fk8waNzWAznPrDImD89yQGJKr6gd890qTPZ3G9VHQtf8j7ayAeEtaL6D
	hZWqP28XyeNBYXB0iTQUKkuncoGFtX/xXPFUaJUO/SABf/Ab2GH6vfWEVEnYKEDCxBEvQT5t0M+
	Jz9uNC39aHlZgvQAtah/Uvc5w7Bcg+leGLmsV8g+k43FMLsMFBNKrnyiu5on3l2bUyqwVaE3dxe
	NtPe9sV5q27up+jQ3ZImbcpGli0PIIzxeAuCOqPziLfARJtlChYtakahTanw7zJhKmJcIZT2YrK
	V4h7EYy63EIa5fogNRkNEH7g2SPfFw9ajbj60gfccCf8crZ39Vyf3bS4A+lOgC/LSL5sTjpVCwY
	edVxoJXdjt6+UGMgKxyfyXUZxA+arUcZAXBTdd75ZL4YQ2L+koE072osmpWzhN9dJ+bQfcwsyUq
	QhpRCngF0VU3rr9jsHXEaGwcPaiNnrIkM4FG6pMJrTn6qCynsLzOob3OnRySRkhgabKsvJzh9Qg
	n4f
X-Received: by 2002:a17:907:3d45:b0:c16:1901:6ba1 with SMTP id a640c23a62f3a-c16b47c50b7mr857110866b.34.1784660655267;
        Tue, 21 Jul 2026 12:04:15 -0700 (PDT)
Received: from misharu.home (2a02-a463-a071-0-1315-eb9e-fdea-db07.fixed6.kpn.net. [2a02:a463:a071:0:1315:eb9e:fdea:db07])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ebad78sm8903366b.46.2026.07.21.12.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 12:04:14 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hari Mishal <harimishal1@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/damon/sysfs.py: clean up sh processes used for obsolete_target test
Date: Tue, 21 Jul 2026 21:04:04 +0200
Message-ID: <20260721190404.135937-1-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The obsolete_target test spawns three sh processes and uses their pids
as DAMON monitoring targets.  These processes are created without their
own stdin, so they inherit the test program's stdin, and they are never
waited on or told to exit.  As a result, they are left running (or
become zombies) as orphaned children after the test program exits.

Give each sh process its own dedicated stdin pipe instead of inheriting
the test program's, and after the targets are no longer needed,
communicate() with each process to close its stdin.  This sends EOF to
the shell, which makes it exit, and communicate() then reaps the
process.

Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
 tools/testing/selftests/damon/sysfs.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index aa03a1187489..d3d50a5a1d56 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -328,11 +328,14 @@ def main():
     kdamonds.stop()
 
     # test obsolete_target.
-    proc1 = subprocess.Popen(['sh'], stdout=subprocess.PIPE,
+    proc1 = subprocess.Popen(['sh'], stdin=subprocess.PIPE,
+                             stdout=subprocess.PIPE,
                              stderr=subprocess.PIPE)
-    proc2 = subprocess.Popen(['sh'], stdout=subprocess.PIPE,
+    proc2 = subprocess.Popen(['sh'], stdin=subprocess.PIPE,
+                             stdout=subprocess.PIPE,
                              stderr=subprocess.PIPE)
-    proc3 = subprocess.Popen(['sh'], stdout=subprocess.PIPE,
+    proc3 = subprocess.Popen(['sh'], stdin=subprocess.PIPE,
+                             stdout=subprocess.PIPE,
                              stderr=subprocess.PIPE)
     kdamonds = _damon_sysfs.Kdamonds(
             [_damon_sysfs.Kdamond(
@@ -356,5 +359,8 @@ def main():
     assert_ctxs_committed(kdamonds)
     kdamonds.stop()
 
+    for proc in (proc1, proc2, proc3):
+        proc.communicate()
+
 if __name__ == '__main__':
     main()
-- 
2.43.0

