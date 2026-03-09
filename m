Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95358126C17
	for <damon@lists.linux.dev>; Mon,  9 Mar 2026 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773018036; cv=none; b=DRr45ZnkicfUs0t3WODmZzG78FU1HHLcwdlzDYz//4Th2lmBL0rrGWxozUZ0/wmSUnE5bCg3TAOdSUZMk1f+BffkjGtC5hQ581U9HCdl/T1llUXzL1REsex56Y7C0xh97cPyQV1fz74/68YW7Xj4jHgxAJ7PtqQdT/BnKac+8zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773018036; c=relaxed/simple;
	bh=3VIwPvEn9nxnA8AoCor8wMrtyb5xyOpGHXiaEf6OlmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5Br3ZJ2PAjwf3gTM7Q3+KzP3eTd44G8NV3hWRLh69tWgLLUfSRN9vJauAvdVL4DKLo/u6NeIuyS+d73IAK7KSIS4h1mda9FOmKreqXhZOLZCq4Ykt24cqONkPe/5gWwah6U6Zk/HKn+X/9W6hu4Qh0m8lGdXh9Y4zjijhEyluE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRXk+oLA; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRXk+oLA"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-829afe24fb5so1256760b3a.0
        for <damon@lists.linux.dev>; Sun, 08 Mar 2026 18:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773018035; x=1773622835; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuMq4xsGI5hOeMCXdX2jtMmL9otI4kV08hHjKDYLLy0=;
        b=NRXk+oLANBbDqY4mLQfTTRLiCeLnEf51vSnK1HrLQYZat/f1uK5WwvOJeQImB+scfC
         Ds5JKKG/r2mNHxX2EjsJCuMru6W7Hbi7Y6T0m3IKqq4wxITFY6xB66+1Ve+6amyTRvKk
         OE0/mvq8Y072GhTpDS6IQj2NK5+aiTUuy+P7rYCgFW/qPFndrsiBz/fT4kKI7mgTn3EF
         7AJ8esam4jWwX+nq8Sy/FXihSl6RezL/iweojqUTJ3ls5o3pfHF+NrYpsDWoFO3vtEsN
         7UhP6MiJtqrcq2iqLSYKV6Zi/afW3qHXzUNZIme5GQdP3zG8CK/ZSi22rACeM5blvuHU
         90Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773018035; x=1773622835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OuMq4xsGI5hOeMCXdX2jtMmL9otI4kV08hHjKDYLLy0=;
        b=D460DzG/oUQebNwWM7TQYoq42N7fb54SeZVvxjTUnSB+WiC3O0TGJ7XMW9pTaEjw8P
         Dz2d6MxLOvARQMr9Qv2gcPu5dTwyTQMljKioFYXtkhSlurgzb+MfMmipibAW3+TZ9oYa
         REJNu6L07N0wrB87O/QvdiGzZsAqtTyts2t+9vs+snU+ZjXLmbp53wHfmXjOt8301W+b
         d9gj3hMSfD5cxrtruP/wVS0lXYIZ6i34xmvGbIYVGiy+TwQYAgb83OT143nZWfdnIL1e
         ZbwfTpD4E0BSmCtXnD2am8gbDSMyXqkK2y9UeVfpzQfHq7SA+PCenBNjZRgR0fdQpIti
         97Dw==
X-Gm-Message-State: AOJu0Yzd3Zi8uzBQSQBgfmFEmJj5SHqCWVPEqZWj/ukMxB3ICC0orvdu
	tzlrzHcoi6sxe/aEhdCiYQK4CXkYnRXnvBH3Q0BrfpwPHcaIa3rlXTXJnnEMag==
X-Gm-Gg: ATEYQzy6SXLe8YjCXWcsuf4VUQ66kbajNw85DzQCopvecQj4DD4TYw3xNUN4ZJvWIJk
	l3HMW+4cIqWiBRPU+OePm9IUiaaaqJJi+SEvmUMo9yVXjWbNaMeKiEREeeu28Vq7d2/UbmX/t0E
	tcl0/zlp+ZDn6hqJmDKdyy6z3av0PP4oIyur8Pq/VkfNNymfOY6f0PYeAmgT1TTn4L9ocdcsQYc
	In1xHXKyg/zUSV+/JCChIJz9lRx0hrhVJn2ru/+xhXL6Y8Xe/70mTs35EniIoDnH2HRTrKXbnz4
	zP/3Mv31jr7PU07aDk+AMJj4GZAjqHZvStkfHxClD8n+TO/ymgF5/822XYuunilBJDJ0gCufPis
	nTtFhcvoMMNA6awfyZYd7407R+8CaHN9N5FqnADhAY8sBLIkmuIux4TU7fBLRCACugRGIR+U3P5
	bHuxAB+1PQQKU31qN+jM4jO9MIYfCBNBRZ6wWEqA==
X-Received: by 2002:a05:6a00:c95:b0:823:edd:20b9 with SMTP id d2e1a72fcca58-829a2fa9676mr8854116b3a.61.1773018034754;
        Sun, 08 Mar 2026 18:00:34 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:35e4:35af:8d0d:ad4c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4635d62sm8468794b3a.5.2026.03.08.18.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 18:00:34 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org,
	sj@kernel.org,
	akinobu.mita@gmail.com
Subject: [RFC PATCH v2 2/6] mm/damon/core: introduce struct damon_access_report
Date: Mon,  9 Mar 2026 10:00:05 +0900
Message-ID: <20260309010009.11639-3-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309010009.11639-1-akinobu.mita@gmail.com>
References: <20260309010009.11639-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct damon_access_report is borrowed from SeongJae Park's
DAMON extension project [1].

[1] https://lore.kernel.org/linux-mm/20251208062943.68824-6-sj@kernel.org/T/
---
 include/linux/damon.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 49d2983af4a8..5f2870ae02ba 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -110,6 +110,30 @@ struct damon_target {
 	bool obsolete;
 };
 
+/**
+ * struct damon_access_report - Represent single acces report information.
+ * @paddr:		Start physical address of the accessed address range.
+ * @vaddr:		Start virtual address of the accessed address range.
+ * @size:		The size of the accessed address range.
+ * @cpu:		The id of the CPU that made the access.
+ * @tid:		The task id of the task that made the access.
+ * @is_write:		Whether the access is write.
+ *
+ * Any DAMON API callers that notified access events can report the information
+ * to DAMON using damon_report_access().  This struct contains the reporting
+ * infomration.  Refer to damon_report_access() for more details.
+ */
+struct damon_access_report {
+	unsigned long paddr;
+	unsigned long vaddr;
+	unsigned long size;
+	unsigned int cpu;
+	pid_t tid;
+	bool is_write;
+/* private: */
+	unsigned long report_jiffies;	/* when this report is made */
+};
+
 /**
  * enum damos_action - Represents an action of a Data Access Monitoring-based
  * Operation Scheme.
-- 
2.43.0

