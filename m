Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B653322B6A;
	Mon,  8 Dec 2025 06:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175441; cv=none; b=jfXEa9u/YV8bNv8OgEbuxtwUGJFIZo0Kc8UZUIZ9fDr2W7eejx0mE2GEZ4XaDWjYwriALqbtHLi/6TSO2i93XTv9QSAFmEhJXIt0Z6tklpbIRj6QP9juF93uXfcLHnvmheSRt9seoR+rFQaZi8gx2Y4sLBEu4dSRV2MTTcDIBxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175441; c=relaxed/simple;
	bh=RBgupw+0+IFAQYuywBDofV0MFSFxSZkVNemgNSqd6d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sa5OEovSuOfC66Mefg3uzuvtcKSmny/41+0hNSV7hkOaAQIT88e+ZMBT1amYGqiZr/aEGj+VM3P/uA3RozmxFOsnRvGJuJfEiSGKZVVavEEJMk+/KoG/H6bs9wvCaP/7+B2d+jGgZzmtdXNuE16HoEQSd+X9DTzprXMfQDysj6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEs8xFy9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEs8xFy9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E86C113D0;
	Mon,  8 Dec 2025 06:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175441;
	bh=RBgupw+0+IFAQYuywBDofV0MFSFxSZkVNemgNSqd6d8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QEs8xFy9N/5t6MNK2CW9AAKR6gDNiwtRhj8gFt5ysY2bEKeVLIvwaRR/qG925Ypc2
	 64UnTu0Zd/Oyj/x+WezlY5QUBF6+gk0sNwB1wrGtSYiT2cIlajPMqNFriu35CaQYyW
	 uJSfF5aQP7wPFdZ9SYEfJUgQeDjB2PQDtkF6fPWt5rNaxZJ90HRSuFIngFYB+itSdE
	 1hbpcmy4Uc1E1kMcpDAmlIuwDlWc2+f2UQz0kq8y8lYCUBoLfb2E5ecL3inu0dgdU/
	 TWH0+AzWqtrCn/xMZrNdLQMrt67rpb8tnfnF6nghvTQiDYEzVZ9qtjcAaUms3XANOw
	 qqQzxtBHmf7Ng==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 33/37] mm/damon: support reporting write access
Date: Sun,  7 Dec 2025 22:29:37 -0800
Message-ID: <20251208062943.68824-34-sj@kernel.org>
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

damon_report_access() callers could know whether the reporting access
was for reading or writing.  The information can be used for
fine-grained monitoring, such as monitoring only read-only accesses or
write-only accesses.  Extend the reporting data structure so that the
caller can pass the information.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index e3408280ea72..9299fc91ba27 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -117,6 +117,7 @@ struct damon_target {
  * @size:		The size of the accessed address range.
  * @cpu:		The id of the CPU that made the access.
  * @tid:		The task id of the task that made the access.
+ * @is_write:		Whether the access is write.
  *
  * Any DAMON API callers that notified access events can report the information
  * to DAMON using damon_report_access().  This struct contains the reporting
@@ -127,6 +128,7 @@ struct damon_access_report {
 	unsigned long size;
 	unsigned int cpu;
 	pid_t tid;
+	bool is_write;
 /* private: */
 	unsigned long report_jiffies;	/* when this report is made */
 };
-- 
2.47.3
