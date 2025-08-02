Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3240317B505;
	Sat,  2 Aug 2025 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754153668; cv=none; b=fj7U94rIsOOw0UD+I8gcjZBfeTcMTQ7yGqXS+6H6NEaeH81mzTzrlnR+NH/r9sRCp5CtZqC/YI12QRRxSlbJk1+lCSfz0Sbd2zuO7wbBmz5vtBzXxr2I44RCJUFpXrqtADQ8uPogfyIdp6VqdjDTHBgHQ92dO8n+sJNryvcM8fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754153668; c=relaxed/simple;
	bh=AX85VyhxhnSPCKuS6eMk7UaT+Kv8vjrbD1Hos2IBnSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mKO6Al7I4fXWUkNoVKvigUqcb7SOit1kkE+x+xi+dbRcFFt9EPVdTVKriEdKUxFugccu8UGzvvygjQRmWzZ6qXsGwscbqKwIoF6NjjeCTQ36CIerKv0uhPq6NDq/2956XxI2V2ja0Ymf9hwTrvI7rFLr8NFCa/1OJHRD2owN/G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKQi/ImC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKQi/ImC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949C4C4CEEF;
	Sat,  2 Aug 2025 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754153667;
	bh=AX85VyhxhnSPCKuS6eMk7UaT+Kv8vjrbD1Hos2IBnSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iKQi/ImCONVsu2B6kD6dPYytCnW0ab+2A7M7ls7rcuQZRn0pqtqh/2OMBFixaGt20
	 MJey1bzkq+Kucqpmp9XBkHbmV0lR3eZTV8dwFbU2Sk6QIt3AjA6OxIxx86UtjY7cic
	 f2v4mI+wZRiWpTStpK62oviabjvBd986b5lhblgfZduzSoKMcr/eMSYkiKX/kC7wqd
	 6x9ZPoxiLiwcc0xH4X0kC2moSlE7cfifpVuTrM7OZ1gWuhvhel4mwNuICQ9mhvVwoN
	 ugnkKuWPOcmx8h0n0rFvMcLg1wj4VuAGWAEt//0Rif/Xdh8tHaMEXwSuyVMw6W/mPd
	 l9BnA5QabuikQ==
From: SeongJae Park <sj@kernel.org>
To: Yueyang Pan <pyyjason@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v4 1/2] mm/damon/paddr: move filters existence check function to ops-common
Date: Sat,  2 Aug 2025 09:54:25 -0700
Message-Id: <20250802165425.7088-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cbe01740f7ac5ac7c9fd1ca367d297c3d7f2a69d.1754135312.git.pyyjason@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat,  2 Aug 2025 11:52:45 +0000 Yueyang Pan <pyyjason@gmail.com> wrote:

> This patch moves damon_pa_scheme_has_filter to ops-common. renaming
> to damos_ops_has_filter.
> Doing so allows us to reuse its logic in the vaddr version
> of DAMOS_STAT
> 
> Signed-off-by: Yueyang Pan <pyyjason@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
