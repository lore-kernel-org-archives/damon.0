Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DFA62A
	for <damon@lists.linux.dev>; Fri, 11 Nov 2022 02:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1668135327;
	bh=BL3Df7T2fda2YYRMS2L+HCFmYgkJzAzwFsLU2JM9Hkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BTPFd3z+Qcu9kJljUBOehk7+i91YGIC9L/yQC4fmAbyc99tYFTyuTnB0vYnTLFUsn
	 cgFCqQemEuFYLr0ygT6AHX8IFWovz8ZsJofMoV89v2op1YujbXnfAG5LwkTvWywf0f
	 lp0INhGv9YdL8SIpwL/7nPUQLSVc0hOMxVpHk9O0=
Received: from localhost.localdomain ([111.199.191.46])
	by newxmesmtplogicsvrsza2-0.qq.com (NewEsmtp) with SMTP
	id 95619E78; Fri, 11 Nov 2022 10:37:22 +0800
X-QQ-mid: xmsmtpt1668134242to097gvqf
Message-ID: <tencent_32CBE47252C5F69571B40751DE6054082D05@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9pmo2KIyz9dprN6UpTtnMoo5DdTsNsP5dbyXhL/Dto/WxKS/eji
	 yPnSz9aKaiLE8FYJd/UyyLYRg8KD7lbY5XwlDrzbMiMCFnXnziV/ouqi56ahVuJPpKDMYivtPHj7
	 hEdOKJu8hyeuPO0TJH1Am3Fyzi5WdqU+vL51uVMogq/cnZwMyqhoH5xeTR5a9Y1wwrCMjeyjYnAO
	 Kn3426Ha/lty+eUNfldE4meYk8g7blNbaGMvkA3SMPfUhayvMa0meed1BZUynFsz3g0Q8S0qaKts
	 mG3g3PZcvTbibyrAwYkUq1gwStRxoygKDFn6buaOLXjKHS0Tgp98MEHrUopCY/XDyxhrbHghf/If
	 E0NGyuFmAVJk89c6sJUEofJ6ffZXzjXXmQ0Wp5No8CxPFpwdmDHzOchxPS0Tf1LW4JkyqjwneM23
	 prUgJTFe5IFekbfM61Mkez1L+e9is4orQr0EDJWQLs1FETG0T7kVCgbIAkRRpKQeEwbZGRAMICd6
	 cO2PfCcGo+g90Sx+bQyGvLmyRHFN4Trt65w7tC87SBtrogIaPZew20LJXFFaRpk0Laf1sG44Ycw/
	 xoQ3Qp/dnjOeOakhdrEOUeCtjBOvLdixMSyB02RD4naS8WW/q9mw35sY9oKeU004o4vGfGG7xfDF
	 //txyYHrQalcHVOQF7G60c76Qou3cw6ulBmX6y3Z/ReGmJx97+ILWOzsP4oybqtA6UiNjm9bIIBk
	 fIZsuCq7SU+2a4WMXx6LuO24Zyl17TrAQnvIabW4zGOxjYpdEbT8VrsNVCbmRkncq8wQ0W7eeIET
	 vHUHsOl3YMe5lAiGdM4TbHRL7VG/xUwYD9NcvgLeSd2UlYB6mD/yFI66ZcMskfsDaEevjZnJBv3E
	 W7bcBMkjoCsNezWV17gi7vqMzqoqfK5IzMGePHJdyl4994IMru+xwppnN7Y0awKFbgPUyn2o1tYf
	 N8xrVY5VUhMHNpyNlQgrKiy7KzEkRIXrkckUDftwNGsJ3ZEkXBqLzOpIuE0CQbM+A4mAmBqHJjIM
	 CMBHVEQw==
From: Rong Tao <rtoax@foxmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	rongtao@cestc.cn,
	rtoax@foxmail.com,
	shuah@kernel.org,
	yuanchu@google.com
Subject: [PATCH] selftests/damon: Fix unnecessary compilation warnings
Date: Fri, 11 Nov 2022 10:37:20 +0800
X-OQ-MSGID: <20221111023720.15408-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221110200939.101886-1-sj@kernel.org>
References: <20221110200939.101886-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

When testing overflow and overread, there is no need to keep unnecessary
compilation warnings, we should simply ignore them.

How to reproduce the problem:

    $ make -C tools/testing/selftests/
    ...
    warning: ‘write’ reading 4294967295 bytes from a region of size 1
    [-Wstringop-overread]
    warning: ‘read’ writing 4294967295 bytes into a region of size 25
    overflows the destination [-Wstringop-overflow=]

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/testing/selftests/damon/huge_count_read_write.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/damon/huge_count_read_write.c b/tools/testing/selftests/damon/huge_count_read_write.c
index ad7a6b4cf338..8fbe276870e7 100644
--- a/tools/testing/selftests/damon/huge_count_read_write.c
+++ b/tools/testing/selftests/damon/huge_count_read_write.c
@@ -8,6 +8,11 @@
 #include <unistd.h>
 #include <stdio.h>
 
+#pragma GCC diagnostic push
+/* Ignore read(2) overflow and write(2) overread compile warnings */
+#pragma GCC diagnostic ignored "-Wstringop-overread"
+#pragma GCC diagnostic ignored "-Wstringop-overflow"
+
 void write_read_with_huge_count(char *file)
 {
 	int filedesc = open(file, O_RDWR);
@@ -27,6 +32,8 @@ void write_read_with_huge_count(char *file)
 	close(filedesc);
 }
 
+#pragma GCC diagnostic pop
+
 int main(int argc, char *argv[])
 {
 	if (argc != 2) {
-- 
2.31.1

