Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA39631B82B;
	Mon,  8 Dec 2025 06:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175413; cv=none; b=JQaesU8ZZTLlemqrYBmTpAj0bQMMFn5QiIYKaLLUX2a/qorYW77MBEvn6oALbhVPqwsO8jcxMtZazI1mhCR+CKEx54ZidUQs+ZhMFt4htXyvV4w1lQJv53u0kUau5v7Cgdnk1L0Oz218tD7XqCc29N9mMp2IEcJZWr/4vWykYJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175413; c=relaxed/simple;
	bh=DBAN6hkU/P5RDm6zU3vPLM0u0djvJ5SiKcRHSXDFMxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhjyw1+Wy12YiVlzZUqGIPwaYOPTqx/i0V5RpW9SjSFpD+gb9fl9KiA91sKVXR/s/DbSmSJS9y1fICKRMgI+hItPzarA6+jaHTAwKtwMSf5vT0nupccElG0LbGkf7Y6rCc6mblnMvXlN1adUmKW4msny6SvX/Hb3asx1mJg6fuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9bFz9IJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9bFz9IJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57FEC116B1;
	Mon,  8 Dec 2025 06:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175412;
	bh=DBAN6hkU/P5RDm6zU3vPLM0u0djvJ5SiKcRHSXDFMxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u9bFz9IJ0NFa6OquQ+K7h90ewPoaDRUvo5S3k4xHwsSXIP5d71Z+/NK6jSVU2a153
	 t5QmPH/kEcJc+2qIbDy5odH3l5EKXL7FFsJwYu2kAW+W84JlSl0CmuK2Sbnzc5c6Fk
	 7aiYMY3VS8WuHh06ZSNC4RuDS69q4heswKZttGoQzE3aaCiBaeGnXUAiwNagbPbnZE
	 NsKjJv0/2StxSRaHStwFbxsKxgfxzA0mcfWBzlos2tgiw0INJuuJ+WjO3woN+xBGK+
	 S2WUoXQIIjs3lwquGnwmXicuRu4oOYkT9VGwdhy7MDGfvSoQgUsEd+aA3eY9POSAgY
	 dIZbaAUzOsPwA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 15/37] mm/damon: implement sample filter data structure for cpus-only monitoring
Date: Sun,  7 Dec 2025 22:29:19 -0800
Message-ID: <20251208062943.68824-16-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208062943.68824-1-sj@kernel.org>
References: <20251208062943.68824-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Access information that is reported via damon_report_access() can inform
DAMON not only whether there was an access, but also additional things
such as the access-generated CPU.  By filtering in/out specific types of
the reported access based on such additional information, DAMON can
support more fine-tuned monitoring, such as per-CPUs access monitoring.
Implement a core API data structure for controlling such filtering.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index e23a10ba7c92..78be584ce5dd 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -781,18 +781,53 @@ struct damon_primitives_enabled {
 	bool page_fault;
 };
 
+/**
+ * enum damon_sample_filter_type - Type of &struct damon_sample_filter.
+ *
+ * @DAMON_FILTER_TYPE_CPUMASK:	Filter by access-generated CPUs.
+ *
+ * Read &struct damon_sample_control for more details.
+ */
+enum damon_sample_filter_type {
+	DAMON_FILTER_TYPE_CPUMASK,
+};
+
+/**
+ * struct damon_sample_filter - &struct damon_access_report filter.
+ *
+ * @type:	The type of this filter.
+ * @matching:	Whether it is for condition-matching reports.
+ * @allow:	Whether to include or excludie the @matching reports.
+ * @cpumask:	Access-generated CPUs if @type is DAMON_FILTER_TYPE_CPUMASK.
+ * @list:	List head for siblings.
+ *
+ * Read &struct damon_sample_control for more details.
+ */
+struct damon_sample_filter {
+	enum damon_sample_filter_type type;
+	bool matching;
+	bool allow;
+	cpumask_t cpumask;
+	struct list_head list;
+};
+
 /**
  * struct damon_sample_control - Low level access check sampling rules.
  *
  * @primitives_enabled:	Enablement of access check primitives.
+ * @sample_filters:	List of access check sample filters.
  *
  * DAMON collect low level access information using sampling, and aggregate
  * that to make higher access pattern picture.  It can use multiple sampling
- * primitives including page table accessed bits and page fault events.  This
- * struct is for controlling what sampling primitives to use (enable).
+ * primitives including page table accessed bits and page fault events.  It can
+ * also filter in/out specific types of sampled access events to monitor
+ * accesses of specific types, such as access-generated CPUs.  This struct is
+ * for controlling what sampling primitives to use (enable), and what sampled
+ * access events should be filtered in/out.
  */
 struct damon_sample_control {
 	struct damon_primitives_enabled primitives_enabled;
+	struct list_head sample_filters;
 };
 
 /**
-- 
2.47.3
