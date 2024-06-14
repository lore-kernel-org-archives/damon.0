Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2AF18410A
	for <damon@lists.linux.dev>; Fri, 14 Jun 2024 03:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718334027; cv=none; b=KgQ62rXU0+vvlTMS0BDBEB76C58I6TP1VYOeEvqu0NjgXpNaOrZZNHh/SAM7w59zO86Ot8ASSUF8v5TOfIxSnTlGpA+Z3c9cwGmVUYhiD2iiapfgI2NhMUpyebE7qgDxdGleHvQhlYUogcGSyEZPCTVxQx722WZ9ktQSN6y8zmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718334027; c=relaxed/simple;
	bh=ZfLljOt/MQv0L/bYy4Os+q7oWfrMxhmdpGjsjZA0zWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7JPNh4Lj3fbUJaFEN6COdeBtDfBY8nUxuNdqtbNW+1YEQQ9OJmBo9NYN7X7/PsSUCtFtkuIVQ9D/wQI9Q0j1hBSbu8qk7kxDhC4NWBGmGqOgOL+cgtYnTpsVCuYJ2T2NOGzwXBYY69Mu6UWpOZdqXlEynlCWuELOh/j9iUoajA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-39-666bb2453c5c
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
Subject: [PATCH v6 4/7] mm/migrate: add MR_DAMON to migrate_reason
Date: Fri, 14 Jun 2024 12:00:06 +0900
Message-ID: <20240614030010.751-5-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240614030010.751-1-honggyu.kim@sk.com>
References: <20240614030010.751-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsXC9ZZnka7rpuw0g78veS0m9hhYzFm/hs3i
	/oPX7BZP/v9mtWhoesRicXnXHDaLe2v+s1ocWX+WxWLz2TPMFouXq1ns63jAZHH46xsmBx6P
	paffsHnsnHWX3aNl3y12j02rOtk8Nn2axO5xYsZvFo8Xm2cyemz8+J/d4/MmuQDOKC6blNSc
	zLLUIn27BK6M6U07mAsauCoaZixkbmBcx9HFyMkhIWAi8eXmJ1YYe8WK+UwgNpuAmsSVl5OA
	bA4OEQEriWk7YrsYuTiYBTYwS0w69wKsRljASeLTqynsIDUsAqoS/95IgIR5BUwlGr9NZYcY
	qSnxePtPMJtTwExi+rF7YK1CQDUXrmxlgqgXlDg58wkLiM0sIC/RvHU2M8guCYHHbBLflz5h
	hhgkKXFwxQ2WCYz8s5D0zELSs4CRaRWjUGZeWW5iZo6JXkZlXmaFXnJ+7iZGYAwsq/0TvYPx
	04XgQ4wCHIxKPLwez7LShFgTy4orcw8xSnAwK4nwzloIFOJNSaysSi3Kjy8qzUktPsQozcGi
	JM5r9K08RUggPbEkNTs1tSC1CCbLxMEp1cDY9PFilmcz1xyN2+uvTj/t9kbMfVszi8yxyX+5
	G5RmvK/5n71x03Gbaw9PzEg3f6cnYv7K23bF0b4t6QtcfevPfPFarbpLcWHtiV+6xVfDH3tO
	yusNOr5UQFjY//DvupvL76jFv/S2in6578LtH7qlqdtmO/L5JpntLSo0vZFbluLRfeRFPNs3
	JZbijERDLeai4kQATVedRH0CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsXCNUNLT9d1U3aawbatjBYTewws5qxfw2Zx
	/8Frdosn/3+zWjQ0PWKx+PzsNbPF4bknWS0u75rDZnFvzX9WiyPrz7JYbD57htli8XI1i30d
	D5gsDn99w+TA57H09Bs2j52z7rJ7tOy7xe6xaVUnm8emT5PYPU7M+M3i8WLzTEaPjR//s3t8
	u+3hsfjFByaPz5vkArijuGxSUnMyy1KL9O0SuDKmN+1gLmjgqmiYsZC5gXEdRxcjJ4eEgInE
	ihXzmUBsNgE1iSsvJwHZHBwiAlYS03bEdjFycTALbGCWmHTuBViNsICTxKdXU9hBalgEVCX+
	vZEACfMKmEo0fpvKDjFSU+Lx9p9gNqeAmcT0Y/fAWoWAai5c2coEUS8ocXLmExYQm1lAXqJ5
	62zmCYw8s5CkZiFJLWBkWsUokplXlpuYmWOqV5ydUZmXWaGXnJ+7iREY4stq/0zcwfjlsvsh
	RgEORiUeXo9nWWlCrIllxZW5hxglOJiVRHhnLQQK8aYkVlalFuXHF5XmpBYfYpTmYFES5/UK
	T00QEkhPLEnNTk0tSC2CyTJxcEo1MPrUNa+7oH7k9/8HOuKSx2ZXixj/OxBddF9Kwnnj9kM8
	urVLV0mqV5sFWv9mebp94xH7mifK91eIMLTX15rF+K3ZHbEmpETj68qlNqnNfjsLPuxftU/l
	C+dcbQX+TWYawXvWJLpVnr3ZzKUe9aeGJ3O+TgBryeL/Z/Rz/vR+TJswY63avta52UosxRmJ
	hlrMRcWJAMj5IFltAgAA
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

