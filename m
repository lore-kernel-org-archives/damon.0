Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF393E7BC7
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 07:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496025; cv=none; b=J7AQzE9YfvT6lB5UTQ9vPTY1F9KsXcu4SwwFMNzH+YPhyp+70iF0DXZh4dnfOatl1i6b9L+21cb+3c+Kc1aManDrarZZ7NLfVvwSEC1R1LkPYfeutKTM4TbKU8sKDCurdS3SQp71GQtAxkfet/4HCvJqSNm2PNzHJdSiG3TTNhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496025; c=relaxed/simple;
	bh=9HIgd/suvnqugdJZxiojG8df5YQ2DpWRG1gL4GMZaHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JobOsTZoehIT5zvowSZkuFtUgKp5D1e8/GkEAnyU4x5e08l23u9e/TnoXds7R5Xnguw2KPPg6Vv054AzTV1U2ubEPnuCEMIqnswbN3hd71f3D6cDRXe9Lzmh1alOTeKHm2WThgaaNEnihqAnZSeT5QFXK4U/Ci8t1zqnufTCJ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYYGUKj6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYYGUKj6"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493c2c7770bso332865e9.1
        for <damon@lists.linux.dev>; Wed, 08 Jul 2026 00:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783496012; x=1784100812; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jCozUlpgp0dXtm0FXnemR31LLTWCBlc2ogyMjG7W414=;
        b=mYYGUKj6LZTYZyqS0h/CPAYAhG7OWAojAphaM1t00QOeisHlEI4eQuWQlyjl6VlNBU
         xk0B1iO+Q9HONIE2+JkWM5oPvdY3a9yzth0dWNnxy+Qn6QSX2+zqmBQFEARot+NdDo3d
         UdXjghoINjHeJpTVXyvwpHykZ/goneBHjojUJUCwv1JdOhb2ouJUG8d5lwqGEZI3zRsR
         aquSAtalyGBENCU9NQFeeCvDiRej7J41ICA/nG/V9g0VftJnmO2l0aXiHyW65fg0zXoQ
         8v7Qv34IvUuBMgVLagL3YL7wl0CfirhpSacP8C0qgm8iGOBX8rkBPOAp08rxfc+WhsHU
         ZAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783496012; x=1784100812;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jCozUlpgp0dXtm0FXnemR31LLTWCBlc2ogyMjG7W414=;
        b=kJ7f4zSXWxl6LGvofp4dfdh4vfxviALRtGbtMmP81cTtyRuRRB18IyCoQVLYrTn3es
         QIwy397KzmGo3m9No9nB6OL1bd7QsCB+chOvX4NGnMtY1X9WeGQ4xqyIVMDD3F2y4cpy
         HTM4r6uC86sgfYENrUsVbDj0jkQAxPk/BE/bUt3JCRBDlzfh3Ruo2I/7JbCPL/abOsS/
         MtRVhl/+NJcudZYG6IDEBWHozzxqqXHy/PiDOOcvo+HMUR1NaOi2PFTSc8qO8MQZBjtR
         6Kg0bewFhEwcz/s1WszOo7wplOB+ida2xYatwXHVwnNYM1fRH/EFh//EZKtG7Ro1G5If
         pVww==
X-Forwarded-Encrypted: i=1; AHgh+Ron8AkBovVnvz7eLl1neOUNhKvI2esWHABKDN2h1topcj2/7IlzlHA67cbd7M97SaMlS0UXRg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhOTufuxA5zBDYCe8iTf3Vqwlsmt2eveKr4GaGNPBfkpJ4QdsQ
	gZ5OJQbYO/doLdxDUP9bN0aTZH2w/rEnDuUWh0XLXcDHF+yu8tV3GvDF
X-Gm-Gg: AfdE7ckkZDL3UHAS7MPg0gfOuPLesdhcmFkfqQhab2DhuE+4Twuy9+R7ofTdkzn5iM5
	o8HVIQYCIAVl0Pt91qbxKaM3N40aHwFkljL0CgNKsJzokdJ6uAIz/o2NavPOziNAum4QVyIk0HO
	TxVW0+RxYDoikNzehC3svM7Ifq9dD5TsKCf677iGVyQKuQ+sXLs3J0qY2eUlMnXPOLLFRNtj0ZA
	XkZWULCXWIa49RQV3C7Hz1/LEZZXUW3AJCo/iUftCkoTQeoblAmqZze308xiJadGiEQ5tFyeDOj
	nvcOaomVptxC+N+I+AO0l9iigU9rS12ZUZk036F3/xnisSv9sbJOHg/Begb8uwhdOqYYBrng5j4
	PFQrF8GW/Hm+2wakSzluSDiyC7gLoV3wrhX81BmSQLcx6xl6fdZUy1MESo1/0T0ZKb6AgG6rV00
	g1Q/BFhLnttPj18S6yqEglBnLW9frjMgt826KmjDHpj4gqtN3o61FeB2lTntZD7naOf0fX8Iv9X
	HPIIo1+wL9pgfv3
X-Received: by 2002:a05:600c:3b28:b0:492:4a7a:e415 with SMTP id 5b1f17b1804b1-493e7e88d26mr1166605e9.2.1783496011537;
        Wed, 08 Jul 2026 00:33:31 -0700 (PDT)
Received: from doehyun-dev.pradel.rg.cispa.de (x06.xlate.fw.cispa.de. [195.37.157.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e610532fsm32876355e9.0.2026.07.08.00.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 00:33:30 -0700 (PDT)
From: Doehyun Baek <doehyunbaek@gmail.com>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>
Cc: Dongliang Mu <dzm91@hust.edu.cn>,
	SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doehyun Baek <doehyunbaek@gmail.com>
Subject: [PATCH v6 4/7] docs/zh_CN: update DAMON start translation
Date: Wed,  8 Jul 2026 07:32:43 +0000
Message-ID: <20260708073246.1652828-5-doehyunbaek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708073246.1652828-1-doehyunbaek@gmail.com>
References: <20260708073246.1652828-1-doehyunbaek@gmail.com>
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

