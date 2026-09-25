Received: from mta0.migadu.com (out-129.mta0.migadu.com [91.218.175.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890593DD523
	for <damon@lists.linux.dev>; Fri, 25 Sep 2026 05:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790315068; cv=none; b=KudJaAFearTvH0el8UyFG7vH9ZrjiyVz/5PHOnJ/1NKwHxC6sqJWItTLQ8SdBiF/3sJ24aprMG5dqDNrg+rZEc7gASNgveyKyHo98MZ7l12MMzdGNlmprK+YW4e70IJqFrqhegJKqmcg/WOAPWX7y/JigLUOMFud2cQc8UFh9h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790315068; c=relaxed/simple;
	bh=5F6F7qba1uzyjFZMv+EeaWChEVyxbKI9bB3fX112gzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wf99/q/VWGoukd5W5oOWtamNZ/IrOAy/k2IsMH66LNuhY9nfslh9ajfUMOyiEOig2u1tnlOEAc3caf+L2fWUq9g6cgINXjpi0s95D7PVQXKhtCsviXUJDAaQOzbJMG+h6oW9Rc1HxRWPwNmJyGTla1BnZBOi7bA+Nf9g9iBkj3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o1wGczzr; arc=none smtp.client-ip=91.218.175.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o1wGczzr"
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=5F6F7qba1uzyjFZMv+EeaWChEVyxbKI9bB3fX112gzw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790315063; v=1; x=1790919863;
 b=o1wGczzrshXxLV2QjROjX1EmaKEI+0NMLUy52U0HQRDzLQ1pMkq3GfvTcrNhQLweCSz3Vq0p
 mKs/NXaNpLLLX8qmPmIFndk87LGkzNsUM8ScNLgiC30XOBgqrRq9P71CcH6O+gKfnl8HlO00qov
 NsLoSHYcJb3mTj81aMk9vn+o=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 14310745666562df;
	Fri, 25 Sep 2026 05:44:13 +0000
X-Mizu-Trace-ID: 14310745666562df
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: sj@kernel.org,
	mst@redhat.com,
	david@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	ryncsn@gmail.com,
	kunwu.chan@gmail.com,
	lianux.mm@gmail.com,
	baohua@kernel.org,
	xueyuan.chen21@gmail.com,
	Lance Yang <lance.yang@linux.dev>
Subject: [FYI] DAMON and virtio-balloon in DeepSeek's DSec paper
Date: Fri, 25 Sep 2026 13:44:08 +0800
Message-ID: <20260925054408.10431-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

I was reading DeepSeek's new DSec paper[1] and found a nice use of DAMON
and virtio-balloon:

With this kind of workload, an agent may read a file once and never touch
it again, while those pages remain in the guest page cache. Without memory
pressure in the guest, they can stay cached even though the host would
like that memory back ...

The trick is DAMON + virtio-balloon free-page reporting :) DAMON reclaims
cold file pages from the guest page cache; buddy gets a chance to coalesce
them into reportable blocks, and virtio-balloon passes those blocks to
Firecracker. Firecracker can then drop the host backing with MADV_DONTNEED.

And it worked: time-integrated host memory use fell by 21.2%, while peak
usage stayed about the same, with no significant CPU overhead. Pretty cool
to see these pieces show up in another real, large-scale system :)

Kernel work still changes the world. Cheers to that!

Anyhow, I still don't know DAMON and virtio-balloon as well as I should
(mostly I just know the people who built them) :P

[1] https://arxiv.org/html/2609.22978

Cheers, Lance
