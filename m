Received: from mail-m155100.qiye.163.com (mail-m155100.qiye.163.com [101.71.155.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DA3523785;
	Tue, 29 Sep 2026 20:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790713767; cv=none; b=LdMscjs+EgGVF86BUVF79kOrgGYSyI7Boyo37R45Ddz78LIc0IDGd7lmwGkThrqSnY31La6+4ZbzPfs33PaMJ6dAuo2SDQYFwx+FFwox0KXPHJ1OsQMMbwti4ovHOEPPmq5AUB7dN7glaHsN1UWRfzugT4k4Ur0DwO1GfuWLCq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790713767; c=relaxed/simple;
	bh=O0SVgsWU1lSvWpVjmKROD9e89ZMTCMvum3N438FqEq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRmsFtxzZxijFR0XZidYKfTa5Z2/054VZF/nNSBeI0Ittj+TmYdSUonOWQMk7JctN01oELwDYLwoihzUMezAFWv9Dtcm/f+yT6PC32vroAPUdt46c17DMvztUShcbvQmHbw4HXtgIziHZ/2vI5j0IdwhL91g9NKNq09ZXAOb/ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deepseek.com; spf=pass smtp.mailfrom=deepseek.com; dkim=pass (1024-bit key) header.d=deepseek.com header.i=@deepseek.com header.b=gzhKioD1; arc=none smtp.client-ip=101.71.155.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deepseek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepseek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepseek.com header.i=@deepseek.com header.b="gzhKioD1"
Received: from deepseek.com (unknown [61.164.44.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f821470c;
	Tue, 29 Sep 2026 20:32:42 +0800 (GMT+08:00)
From: Jialiang Huang <huang-jl@deepseek.com>
To: lance.yang@linux.dev
Cc: baohua@kernel.org,
	damon@lists.linux.dev,
	david@kernel.org,
	kunwu.chan@gmail.com,
	lianux.mm@gmail.com,
	linux-mm@kvack.org,
	mst@redhat.com,
	ryncsn@gmail.com,
	sj@kernel.org,
	virtualization@lists.linux.dev,
	xueyuan.chen21@gmail.com,
	huang-jl@deepseek.com,
	xiang@kernel.org
Subject: Re: [FYI] DAMON and virtio-balloon in DeepSeek's DSec paper
Date: Tue, 29 Sep 2026 20:32:41 +0800
Message-ID: <20260929123241.1408414-1-huang-jl@deepseek.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925054408.10431-1-lance.yang@linux.dev>
References: <20260925054408.10431-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0ed272b5009cekunm228468aa65c5b2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSEpDVkJNGEJITUtNQ0xJGlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTU9VT09VSk1JWVdZFhoPEhUdFFlBWUtVS1VLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=gzhKioD1B1uZQpMFbOo3brtYlrSTQQuk4RhuZu76oYFOEoxNc+2X0r83h+DMn8d0wDnVxAUyFWufPZPvawOvTRF0WwSWL//a40fpZzwYpaDzfSRnoMiDU/mIhuKP0h+ZpRi0wpdTIoXpnEsWJsZZ1n/Xo3pTBUOA1UoFtNrs4JA=; s=default; c=relaxed/relaxed; d=deepseek.com; v=1;
	bh=O0SVgsWU1lSvWpVjmKROD9e89ZMTCMvum3N438FqEq8=;
	h=date:mime-version:subject:message-id:from;

Hi all,

I'm an engineer at DeepSeek. Thanks for the discussion, and thanks
to everyone working on DAMON and virtio-balloon free-page reporting.
They have been very useful for our workloads.

Gao Xiang wrote:
> It can cause sync 4K faults on the host in the worst case

This is one of our concerns with virtio-pmem as well: moving I/O onto
the page-fault path can introduce performance trade-offs. The other
concern is the substantial struct page overhead for large images.

For now, we enable virtio-pmem only for moderately sized, frequently
used read-only images, where there is more opportunity to share the
same host page cache across sandboxes, as Gao pointed out.

Muchun's vmemmap work is also interesting to us. My understanding is
that it allocates private backing for struct page metadata on demand,
which could help reduce the upfront memory overhead for large images.

For disks without virtio-pmem, DAMON with virtio-balloon free-page
reporting lets us reclaim cold guest page-cache pages and return
the memory to the host, without those virtio-pmem-specific issues.
The two approaches complement each other in our setup.

We have not yet fully explored how best to tune the DAMON and free-page
reporting parameters for our workloads. For example, the kernel's default
free-page reporting granularity is 2 MiB, which is fairly coarse:
reclaiming cold pages does not necessarily produce free blocks of that
size. We still need to evaluate how finer reporting granularity and
different DAMON settings affect memory savings and workload performance.

Best,
Jialiang Huang
