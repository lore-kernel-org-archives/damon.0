Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9630145FF9
	for <damon@lists.linux.dev>; Thu, 13 Jun 2024 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284879; cv=none; b=ZbnxDaRK45dYwrhStga+RbxAA0UaCENxYWibA8XiQJNdHOFrK0PaKlCO/rjOLITYk1JGcZ79YKRA+E0fBLPfuktDxaR0HzGD6uyXC2Y/vpCsJMbViJgkY1dWeL1PmgXNSt5hE0s0MF8c34kykA/WH9Rs3BWateTFkC9jxiIbAyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284879; c=relaxed/simple;
	bh=ZfLljOt/MQv0L/bYy4Os+q7oWfrMxhmdpGjsjZA0zWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nppEGN/QveR9O+0+WnlJIeVq5pcda98Bfqtf/X88B5RNBgNC9e3RWUIMh8bSuXBpQjTUaIRwdp9HigiokWhB4u6P9to0HwYyKgVk2NHkOhn/oUoA4WKkdBpak8qQ8V5/BJtjehRUsRAhyCtrRif5dqrEMR/ek+vdsJYkYh3X8io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-48-666af249b12b
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gregory Price <gregory.price@memverge.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH v5 4/8] mm/migrate: add MR_DAMON to migrate_reason
Date: Thu, 13 Jun 2024 22:20:51 +0900
Message-ID: <20240613132056.608-5-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240613132056.608-1-honggyu.kim@sk.com>
References: <20240613132056.608-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsXC9ZZnoa7np6w0g/WvZCwm9hhYzFm/hs3i
	/oPX7BZP/v9mtWhoesRicXnXHDaLe2v+s1ocWX+WxWLz2TPMFouXq1ns63jAZHH46xsmBx6P
	paffsHnsnHWX3aNl3y12j02rOtk8Nn2axO5xYsZvFo8Xm2cyemz8+J/d4/MmuQDOKC6blNSc
	zLLUIn27BK6M6U07mAsauCoaZixkbmBcx9HFyMkhIWAicafvNxuM/evYFUYQm01ATeLKy0lM
	XYwcHCICVhLTdsR2MXJxMAtsYJaYdO4FE0iNsICTxO8jPawgNouAqsSarmVgvbwCphJfn0HY
	EgKaEo+3/2QHsTkFzCQezX0FtksIqGbGj6vMEPWCEidnPmEBsZkF5CWat85mhuh9zSbxrb0Y
	wpaUOLjiBssERv5ZSFpmIWlZwMi0ilEoM68sNzEzx0QvozIvs0IvOT93EyMwBpbV/onewfjp
	QvAhRgEORiUeXo9nWWlCrIllxZW5hxglOJiVRHhnLQQK8aYkVlalFuXHF5XmpBYfYpTmYFES
	5zX6Vp4iJJCeWJKanZpakFoEk2Xi4JRqYMzvdb376ZQRu1Vv95ILpzZffLrz88L0uUtWPHd/
	8iJj0ufrFUUzivd9MvT08ZL1THnrdWF5xZQrf7ddCVr766BCxD/zZefX6+3ZUicax3Ox4aBv
	UV5ysIDDr+86RfUtfxTnfL7SuPm+9YXdcsudOY09cyf7LJrCaB7xguHk6lPb66s1ONUSCsSU
	WIozEg21mIuKEwER4BI1fQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsXCNUNLT9fzU1aawb4lAhYTewws5qxfw2Zx
	/8Frdosn/3+zWjQ0PWKx+PzsNbPF4bknWS0u75rDZnFvzX9WiyPrz7JYbD57htli8XI1i30d
	D5gsDn99w+TA57H09Bs2j52z7rJ7tOy7xe6xaVUnm8emT5PYPU7M+M3i8WLzTEaPjR//s3t8
	u+3hsfjFByaPz5vkArijuGxSUnMyy1KL9O0SuDKmN+1gLmjgqmiYsZC5gXEdRxcjJ4eEgInE
	r2NXGEFsNgE1iSsvJzF1MXJwiAhYSUzbEdvFyMXBLLCBWWLSuRdMIDXCAk4Sv4/0sILYLAKq
	Emu6loH18gqYSnx9BmFLCGhKPN7+kx3E5hQwk3g09xUbiC0EVDPjx1VmiHpBiZMzn7CA2MwC
	8hLNW2czT2DkmYUkNQtJagEj0ypGkcy8stzEzBxTveLsjMq8zAq95PzcTYzAIF9W+2fiDsYv
	l90PMQpwMCrx8Ho8y0oTYk0sK67MPcQowcGsJMI7ayFQiDclsbIqtSg/vqg0J7X4EKM0B4uS
	OK9XeGqCkEB6YklqdmpqQWoRTJaJg1OqgfGyVKjrnbSye9t6en88fDJv1purIhnujd4uwnNW
	1C9cc8AwY4Pp6etvkj57awk+9dvpXbh6w8Pf1RslkybWfObaacO4yHOSyrfzP3ycQ9/qX5Zo
	enWp9EV+Zs2KuemmG8U3ST8WS2X237o0b0Y6o6/92oLHYVYqN1MMbbtLT0yJ61BjeqHx8pYS
	S3FGoqEWc1FxIgAq+jUsbgIAAA==
X-CFilter-Loop: Reflected

The current patch series introduces DAMON based migration across NUMA
nodes so it'd be better to have a new migrate_reason in trace events.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/migrate_mode.h   | 1 +
 include/trace/events/migrate.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/migrate_mode.h b/include/linux/migrate_mode.h
index f37cc03f9369..cec36b7e7ced 100644
--- a/include/linux/migrate_mode.h
+++ b/include/linux/migrate_mode.h
@@ -29,6 +29,7 @@ enum migrate_reason {
 	MR_CONTIG_RANGE,
 	MR_LONGTERM_PIN,
 	MR_DEMOTION,
+	MR_DAMON,
 	MR_TYPES
 };
 
diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
index 0190ef725b43..cd01dd7b3640 100644
--- a/include/trace/events/migrate.h
+++ b/include/trace/events/migrate.h
@@ -22,7 +22,8 @@
 	EM( MR_NUMA_MISPLACED,	"numa_misplaced")		\
 	EM( MR_CONTIG_RANGE,	"contig_range")			\
 	EM( MR_LONGTERM_PIN,	"longterm_pin")			\
-	EMe(MR_DEMOTION,	"demotion")
+	EM( MR_DEMOTION,	"demotion")			\
+	EMe(MR_DAMON,		"damon")
 
 /*
  * First define the enums in the above macros to be exported to userspace
-- 
2.34.1

