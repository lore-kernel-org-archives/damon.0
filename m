Received: from mail-m155116.qiye.163.com (mail-m155116.qiye.163.com [101.71.155.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB0B526A82;
	Tue, 29 Sep 2026 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687176; cv=none; b=pHYg+E1+alSW1Ei2HhSEP9lXAoDOmZ4n9feGE9xGHEiH9nw2EIEhYXnt1tkhNyICRICoaYu9HrP5VUc/HrpK6LVMJSsIhA3b2WzCWRjx0ArnPGg3XgsYuvFG8hxj8FO5pYpEi1h9JxNdjmNSxQ06wElKrqNVQHOk24buEbLBuyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687176; c=relaxed/simple;
	bh=4URAN5FNzJqUrmdB2RD2kXH3bcqOZ15omLjrDbZ/OsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c34Z+k30l18cYw2DjvtBErrc9JWUoG4KtJeOPhPiO6x1r/FBxD3IAC0Ya9V2XsfIPP0+ZHxK7V18VuHyelZl5RB6AOosC49YXSM15DjPPMpaeFGE3szxJo31c+DPy/KhZ+xjIb8S8pkhrlrRH8d/g0kWI9XxnaIVohphDjsS0qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deepseek.com; spf=pass smtp.mailfrom=deepseek.com; dkim=pass (1024-bit key) header.d=deepseek.com header.i=@deepseek.com header.b=XQeEEh97; arc=none smtp.client-ip=101.71.155.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deepseek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepseek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepseek.com header.i=@deepseek.com header.b="XQeEEh97"
Received: from deepseek.com (unknown [61.164.44.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f8281338;
	Tue, 29 Sep 2026 20:50:31 +0800 (GMT+08:00)
From: Jialiang Huang <huang-jl@deepseek.com>
To: xiang@kernel.org
Cc: baohua@kernel.org,
	damon@lists.linux.dev,
	david@kernel.org,
	huang-jl@deepseek.com,
	kunwu.chan@gmail.com,
	lance.yang@linux.dev,
	lianux.mm@gmail.com,
	linux-mm@kvack.org,
	mst@redhat.com,
	ryncsn@gmail.com,
	sj@kernel.org,
	virtualization@lists.linux.dev,
	xueyuan.chen21@gmail.com
Subject: Re: [FYI] DAMON and virtio-balloon in DeepSeek's DSec paper
Date: Tue, 29 Sep 2026 20:50:30 +0800
Message-ID: <20260929125030.1411980-1-huang-jl@deepseek.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aruyFPzEe3pS_Qzx@XiangdeMacBook-Pro.local>
References: <aruyFPzEe3pS_Qzx@XiangdeMacBook-Pro.local>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0ed377a8e09cekunmd46573a965f4dd
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTx1DVhpKTE1IHhoaGE5CHlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTU9VT09VSk1JWVdZFhoPEhUdFFlBWU9LSFVCQk
	lOS1VKS0tVSkJLQlkG
DKIM-Signature: a=rsa-sha256;
	b=XQeEEh97ZWY5l5j1XqrZzUlvgTzY4NwurlzEV94OlooafpzLTNgVszlbD0jU9A7ekpsCD+3QqRz9T08bOYrlo/9DD7klOyalW5AYm0SzHoUr/5K5zjc2K4xpDJDY8Ka1NNnqDlD7N0xJcdf4J1YnZpmzQUzJg1l6eTlLoiGfvcI=; s=default; c=relaxed/relaxed; d=deepseek.com; v=1;
	bh=4URAN5FNzJqUrmdB2RD2kXH3bcqOZ15omLjrDbZ/OsM=;
	h=date:mime-version:subject:message-id:from;

>> Muchun's vmemmap work is also interesting to us. My understanding is
>> that it allocates private backing for struct page metadata on demand,
>> which could help reduce the upfront memory overhead for large images.
>
> Although I haven't had a chance and time to look into that, the main
> concern from me is that mmap() access will call
> "dax_fault_iter->vmemmap_materialize_page()", and malicious sandbox
> workloads (or not malicious, just valid mmap workloads) can cause guest
> memory OOMs due to "struct page balloon" for large rootfs in the worst
> cases and cause the follow-up mmap access failure, because the guest
> memory size may not even fulfill "struct page" for large rootfs.
>
> Thanks,
> Gao Xiang

Agreed, if a workload actually accesses a sufficiently large range of the
image, allocating struct page metadata on demand could indeed exhaust
guest memory.

Best,
Jialiang Huang
