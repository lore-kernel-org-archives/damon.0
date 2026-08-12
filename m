Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5027339B960
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 06:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786517976; cv=none; b=WU2pUdOWMQNEr8FpfjifhoUKR1+ZXBR0AMnj7cxS4hyZFM4CZPYj53Dj8uAVWXMR2tBQDH2macH3frr3nrj+3hPtQMUHvSPli7tayJU3e883nzvANcfjrgaXdrhqlqqg7zl/qfuoKshvF37FIkwur94hTBdAkqhcQ4JZAsplLbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786517976; c=relaxed/simple;
	bh=9HIgd/suvnqugdJZxiojG8df5YQ2DpWRG1gL4GMZaHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxoZXCidGaSiXsE2nZ9mHpJbh8s6efgl56YI+B8L2oMPwG9zYb178AQsRbNtD3mKSAUAnWD2COurC7YXNO4eo1aQZYrRoWlWk4J4AcsrxiwF43ZLiw26hcu9Kma+kRY27RG56merB5nCsjEzbCjNC8PpfIgQLqfhtRheuN/TVG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jz1WVK2Q; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jz1WVK2Q"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-495522bc0e2so195155e9.2
        for <damon@lists.linux.dev>; Tue, 11 Aug 2026 23:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786517971; x=1787122771; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jCozUlpgp0dXtm0FXnemR31LLTWCBlc2ogyMjG7W414=;
        b=jz1WVK2QIxPl26w1BHV46R5CFDYCBF2cZK2sUKgHWmWtKbLukvBPHXntrPzruJ9clx
         ogpgcHqBAttLGtDy+pTCur3GqALBHkwisNLTcjFS6Wd+POYj377JmKJCAerIWjCT7xPJ
         0C3RznR+bIiprDlaIeT3XCDzJcsfQ0X6Nu8/gvzAbebIXwP9PsOUIoQr/5QTNRf6fBhK
         tXb49l4CaAJD064o8SmvGuzfwwV2UeuB0bsKydufrGgvhOEqC5DwyzFarrbBHOA+svJ5
         r5uBjkabbhbZ9uRK57ZVAd8vM4YHCV0XGUk5QCfXaOKvLSTlT59AWbIhAumr/MIPdWli
         yVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786517971; x=1787122771;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jCozUlpgp0dXtm0FXnemR31LLTWCBlc2ogyMjG7W414=;
        b=DoNx4PfNLns7JYhugPw6V+wVXZVDg/Rp34HDbWMMFenDFQp9bEO57YZKSzUnapW2GW
         Imxc2oJ9eIAvRaaKc5fXAe8nn1tO0lQSCABoALhWZuJYXJhgNRijuv6vHEqfKbE7ZOQG
         u4LTWqqJkN4+ddIL7ItdTCgPQisCzVcfbo1gBIELCsOOYJUClxclb9XqJIvXSlOOJOsT
         VcWCcq7ITmbMy8lMib835deAJCgaEN4VfsWVCqTxC/nV0mmgk7/Yq7Lg7zre4sR3KNEa
         fbFKaOLzJjgIVBsZKh3BuPar6wvJ56MnsqDx+STtZDGf5yjLw5ftnkWP2JBZR1cTrICV
         hRKA==
X-Forwarded-Encrypted: i=1; AHgh+Rre8syYQ1XCNe+xjyCzJye7HDv0JNQSGTXBDvYAKAcjgh25lYJ6a33rffRO4f4xzQDG2uQqeg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwIf7Fk0AORXfZ1Xst38vWwpFzv1GM78X7sCn2kXoRNnKtQj75h
	qsOfRMQcjVXHmdVWUCe/mbf+6yIQEbhjXq2rT+oLniFb93ta+WOpJyCx
X-Gm-Gg: AR+sD115TAWQKozZhSGtsIfCnynwwreWLr0jIiZfk4JO3FCSYdGG4aJN/iopXeOs1OJ
	sxJ8a0FJordnRjE8OVqS04H7JHmH9mjTnbTQlVkhV5SLpFwxzpyETdmx8w/nyGGjXJ3KVFvsLOS
	C0yVjKZywe0TbtvzI3E3fD1AtIA2pkvA8wSiXWQggE2+T6Ps0JxHy277/u6LDS8aKzhtDyFP5x8
	rP5C1JuuzP/MqaC53QFh76xy73onkRIzKU4BOlAeSrZoc+QcvR74H9KGYLMXAqtuwivfoIisnsB
	V9rNU6yRY3jUxbLPXE17aLLn3GpIj/vbhiGdkCiFKaikw38AD1+KRJFTS8xd2bHGUpPk8VtsQnN
	kl/G/AOuqvzK6vkzqgWh2YXwgwaOu7GMcRvVrDkWr8xXdDGd/0IksGJfAmpZgki098hyQtl05oJ
	gWLCsyl/nV5igu77xmOCy8OPOcr7zelFQtDQYm7z05KVych/FpJO02cYkhm5nQndmdq6DKo6MCa
	zsSkPdWXxwFOgY0F3smlkclZ+NE0NIwdvWIUKvdXOT7xnrE4c83xfOOXmTbYRysi/GomabxYIzi
	YL42xJBvDzRHPF2H7a510QRrdZl/89G1AHvmQHF4LF4q1Q==
X-Received: by 2002:a05:600c:1f92:b0:496:c249:ddb1 with SMTP id 5b1f17b1804b1-4997c1582dcmr14159395e9.4.1786517971073;
        Tue, 11 Aug 2026 23:59:31 -0700 (PDT)
Received: from doehyun-dev.pradel.rg.cispa.de (x06.xlate.fw.cispa.de. [195.37.157.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997b15b807sm73628005e9.7.2026.08.11.23.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 23:59:30 -0700 (PDT)
From: Doehyun Baek <doehyunbaek@gmail.com>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>
Cc: Doehyun Baek <doehyunbaek@gmail.com>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/7] docs/zh_CN: update DAMON start translation
Date: Wed, 12 Aug 2026 06:59:08 +0000
Message-ID: <20260812065914.3071433-5-doehyunbaek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812065914.3071433-1-doehyunbaek@gmail.com>
References: <20260812065914.3071433-1-doehyunbaek@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update the Chinese translation of .../admin-guide/mm/damon/start.rst.

Update the translation through commit c9380cdd949d
("Docs/{admin-guide,mm}/damon: fix DAMON documentation details").

Signed-off-by: Doehyun Baek <doehyunbaek@gmail.com>
---
 .../zh_CN/admin-guide/mm/damon/start.rst      | 63 ++++++++++++++++---
 1 file changed, 54 insertions(+), 9 deletions(-)

diff --git a/Documentation/translations/zh_CN/admin-guide/mm/damon/start.rst b/Documentation/translations/zh_CN/admin-guide/mm/damon/start.rst
index cff7b6f98c59..1a7f3382dd15 100644
--- a/Documentation/translations/zh_CN/admin-guide/mm/damon/start.rst
+++ b/Documentation/translations/zh_CN/admin-guide/mm/damon/start.rst
@@ -35,18 +35,63 @@ https://github.com/damonitor/damo找到。下面的例子假设DAMO在你的$PAT
 这并不是强制性的。
 
 因为DAMO使用了DAMON的sysfs接口（详情请参考:doc:`usage`），你应该确保
-:doc:`sysfs </filesystems/sysfs>` 被挂载。
+``sysfs`` 被挂载。
+
+
+拍摄数据访问模式快照
+====================
+
+下面的命令展示程序在执行时刻的内存访问模式。::
+
+    $ git clone https://github.com/sjp38/masim; cd masim; make
+    $ sudo damo start "./masim ./configs/stairs.cfg --quiet"
+    $ sudo damo report access
+    heatmap: 641111111000000000000000000000000000000000000000000000[...]33333333333333335557984444[...]7
+    # min/max temperatures: -1,840,000,000, 370,010,000, column size: 3.925 MiB
+    0   addr 86.182 TiB   size 8.000 KiB   access 0 %   age 14.900 s
+    1   addr 86.182 TiB   size 8.000 KiB   access 60 %  age 0 ns
+    2   addr 86.182 TiB   size 3.422 MiB   access 0 %   age 4.100 s
+    3   addr 86.182 TiB   size 2.004 MiB   access 95 %  age 2.200 s
+    4   addr 86.182 TiB   size 29.688 MiB  access 0 %   age 14.100 s
+    5   addr 86.182 TiB   size 29.516 MiB  access 0 %   age 16.700 s
+    6   addr 86.182 TiB   size 29.633 MiB  access 0 %   age 17.900 s
+    7   addr 86.182 TiB   size 117.652 MiB access 0 %   age 18.400 s
+    8   addr 126.990 TiB  size 62.332 MiB  access 0 %   age 9.500 s
+    9   addr 126.990 TiB  size 13.980 MiB  access 0 %   age 5.200 s
+    10  addr 126.990 TiB  size 9.539 MiB   access 100 % age 3.700 s
+    11  addr 126.990 TiB  size 16.098 MiB  access 0 %   age 6.400 s
+    12  addr 127.987 TiB  size 132.000 KiB access 0 %   age 2.900 s
+    total size: 314.008 MiB
+    $ sudo damo stop
+
+上面示例的第一条命令下载并构建一个名为 ``masim`` 的人工内存访问
+生成程序。第二条命令要求 DAMO 用给定命令启动该程序，并让 DAMON
+监测新启动的进程。第三条命令从 DAMON 取回该进程当前被监测访问
+模式的快照，并以人类可读的格式显示该模式。
+
+输出的第一行以单行热图格式显示各区域的相对访问温度（热度）。热图
+中的每一列表示被监测虚拟地址空间上大小相同的区域。列在该行中的
+位置和列上的数字表示该区域的相对位置和访问温度。``[...]`` 表示
+虚拟地址空间中未映射的巨大区域。第二行显示帮助理解热图的附加信息。
+
+从第三行开始，输出的每一行显示进程的哪个虚拟地址范围
+（``addr XX size XX``）被访问得有多频繁（``access XX %``），以及
+持续了多长时间（``age XX``）。例如，大小约为 9.5 MiB 的第十一个
+区域在最近 3.7 秒内被访问得最频繁。最后，第四条命令停止 DAMON。
+
+请注意，DAMON 不仅能监测虚拟地址空间，还能监测包括物理地址空间在内
+的多种地址空间。
+
 
 记录数据访问模式
 ================
 
 下面的命令记录了一个程序的内存访问模式，并将监测结果保存到文件中。 ::
 
-    $ git clone https://github.com/sjp38/masim
-    $ cd masim; make; ./masim ./configs/zigzag.cfg &
+    $ ./masim ./configs/zigzag.cfg &
     $ sudo damo record -o damon.data $(pidof masim)
 
-命令的前两行下载了一个人工内存访问生成器程序并在后台运行。生成器将重复地逐一访问两个
+第一行命令再次运行该人工内存访问生成器程序。生成器将重复地逐一访问两个
 100 MiB大小的内存区域。你可以用你的真实工作负载来代替它。最后一行要求 ``damo`` 将
 访问模式记录在 ``damon.data`` 文件中。
 
@@ -57,7 +102,7 @@ https://github.com/damonitor/damo找到。下面的例子假设DAMO在你的$PAT
 你可以在heatmap中直观地看到这种模式，显示哪个内存区域（X轴）何时被访问（Y轴）以及访
 问的频率（数字）。::
 
-    $ sudo damo report heats --heatmap stdout
+    $ sudo damo report heatmap
     22222222222222222222222222222222222222211111111111111111111111111111111111111100
     44444444444444444444444444444444444444434444444444444444444444444444444444443200
     44444444444444444444444444444444444444433444444444444444444444444444444444444200
@@ -117,8 +162,8 @@ https://github.com/damonitor/damo找到。下面的例子假设DAMO在你的$PAT
 数据访问模式感知的内存管理
 ==========================
 
-以下三个命令使每一个大小>=4K的内存区域在你的工作负载中没有被访问>=60秒，就会被换掉。 ::
+以下命令使每一个大小>=4K的内存区域在你的工作负载中没有被访问>=60秒，就会被换掉。 ::
 
-    $ echo "#min-size max-size min-acc max-acc min-age max-age action" > test_scheme
-    $ echo "4K        max      0       0       60s     max     pageout" >> test_scheme
-    $ damo schemes -c test_scheme <pid of your workload>
+    $ sudo damo start --damos_access_rate 0 0 --damos_sz_region 4K max \
+                      --damos_age 60s max --damos_action pageout \
+                      --target_pid <pid of your workload>
-- 
2.43.0

