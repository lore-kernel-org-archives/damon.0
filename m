Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A291380A
	for <damon@lists.linux.dev>; Sat, 12 Nov 2022 05:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1668229346;
	bh=UKrCkq3xKMj8sSLZqZpNU4Q0Lx+VN8Ps1Ny3URH+YVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QmE6AoM+jI44+Oi9YGeGF/G31TjtOxWtVxOKz3GCaCfSZg+40W10fxg+rqDj8CJLb
	 z8NQHFOqwcGKR9AaybqOHkPClgoyKSgiGw9z7pMq2qF0os55MLgZMaRfGia9a1q4Y0
	 C3tolvT9EAgL33Hg2y5Ejh5fcPA32Gd/7jggYlj4=
Received: from localhost.localdomain ([111.199.191.46])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 450F4C4; Sat, 12 Nov 2022 13:01:05 +0800
X-QQ-mid: xmsmtpt1668229265t93w5drhr
Message-ID: <tencent_5695C257F3D13F4417034BA1FBAC95CB3B07@qq.com>
X-QQ-XMAILINFO: NKv2G1wnhDBnrr4E/kVfuAaOl1xdaPmH2g5MNcAlnARbTJTbpo2cOTjBhWNPR5
	 uGpsVe1XUsORP3gpZQmITaJAeWOU6WToXQr8yE9Eojcu1DpdAdsk4lE9iwL04PEGNPaxPVol36N5
	 W0zrLApB5zjHdUMxGZ/+0skjluPgfcViwQtw+YRsmmUNnkjOJi2UAMPx7U+l2OmDha5M+BcjDqbn
	 GqJsdbk0WDCIZpdggcJZboR4Rgp9CqT0qa0hFmPz7JxN8U1fpM6Vre5Hd37W16JgIjInFjEbcF+4
	 ru6MbpqBnGDcM47iWxssziI3GKPo+Lr3hLFt815RGapVRRYXCOWnWXWzJDZXBZrb2LQElxGaqaPq
	 MTh/2hCcjZT1QCZNDUHTAzh+aNE6HaSZmVZVPDmLlgh3JKQpdxtTb6pS5SYJDGzRlEy09oU/peAx
	 ZLMQggZFLf6NZo5srGxkIttroOSR0eBnoQLFQtGXhkrDdtWKacevNdRN0MO6shMziVNjXTxYDiMQ
	 BD45EE5UaAxxv4gSr0bT8jY9UYwNUWDRqTYms5YnBsy04IU3kFZffsrCZM1BrX0czsfNLE1JYQYY
	 k/Me8aVOjGwKsIeGD1f/YsauWxhGEKH6ooD69baH8cg3gCe/qNewUYKCpopvZPevBYXfEa+eZOCH
	 uBlho+DLL7EeNRpf7WHrnngiVahhp6VQ2GS861E3gT+YQaEQOkPCRz/oplB33uvJBUYKiqMTigpz
	 CgSvKsXYYHGamRV5UIFlZEAGQMD6FKDSYGUv6YVOQIv7vRtKQXW7w93+FNR6DC4iaLWe/XAZGbaE
	 0iqWMYfpvMtpPqJbygyqkMHkjQwooiTEhx39CgQrXK7p+HD9w34duXzRuka3IrEbEdeHrUyYZ2zo
	 SH0G3NidKkhxaCFcGXEKYLn4mb4AgHUErt4nHzr6FwkYoDd+bJ84E2ktHfjiANIMPa2JWd3N+6oV
	 +J7Ljiap2SQNvqbFfIPAOqYdOg2bxXQMpISlFq5pFZ2lrlZj405A==
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
Subject: Re: Re: [PATCH] selftests/damon: Fix unnecessary compilation warnings
Date: Sat, 12 Nov 2022 13:01:04 +0800
X-OQ-MSGID: <20221112050104.22783-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221111173855.108360-1-sj@kernel.org>
References: <20221111173855.108360-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Park, I just search on GCC source code, found GCC support
"-Wstringop-overread" at least gcc-11.1.0, commit d14c547abd48("Add
-Wstringop-overread for reading past the end by string functions.").

AND found a testsuite gcc/gcc/testsuite/gcc.dg/pragma-diag-10.c

 10 #pragma GCC diagnostic push
 11 #pragma GCC diagnostic ignored "-Wstringop-overflow"
 12 #pragma GCC diagnostic ignored "-Wstringop-overread"
 13   if (c != 0)
 14     return __builtin_memchr (s, c, (unsigned long)-1);
 15 #pragma GCC diagnostic pop

it's totally same as this PATCH.

I think the motivation for this patch is to eliminate the compilation
warning, maybe one day we will compile the kernel with "-Werror -Wall",
at which point this compilation warning will turn into a compilation
error, and in case we already know it, we should fix this error in
advance.

For old gcc, we can add this?

 #pragma GCC diagnostic push
+#if __GNUC__ >= 11 && __GNUC_MINOR__ >= 1
 /* Ignore read(2) overflow and write(2) overread compile warnings */
 #pragma GCC diagnostic ignored "-Wstringop-overread"
 #pragma GCC diagnostic ignored "-Wstringop-overflow"
+#endif

What do you think?

Good day!
Rong Tao
