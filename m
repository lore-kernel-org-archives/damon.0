Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C82334C24;
	Fri, 30 Jan 2026 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769787501; cv=none; b=HuKuZkLbBlE+b0a+qKnhgmbsQ5nY81u68Ygs7lLiPhSaDdpUNnRSFSeWbpRIgU+K5ExMAPnv4FMOZRZRxo5MQMmmNI2+6+IDqyTO5Cr8h+UWVmkfmxVTl3uq4Wcc1A/zssNSqepKr6c2CrcBopwhpE/rgyE1w/PapwP9bNaSLSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769787501; c=relaxed/simple;
	bh=SG6FWIoaJiK0ZkyIPU7qA28SftwgtJE++lmHxE14I/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AeP61owO1VLFCPBSXkTFivKPrxxJTFrC36fdY8taQfZsRWBWVBsmO+MbKB3ay+mC1K1YQaoPoDbT1xYKmXNxPPhFVrXAX93pR/nYmaGvqHydgOpNIeNohvesis1R4yS1lWfx+DFXNBNLcde5/j6iAt2zKrKNKl4l8quFcclQio8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZY0KbrUS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZY0KbrUS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB84FC4CEF7;
	Fri, 30 Jan 2026 15:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769787501;
	bh=SG6FWIoaJiK0ZkyIPU7qA28SftwgtJE++lmHxE14I/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZY0KbrUS3iafgHIOS/z8sXj5kaZZ1CvEE69JECYv9IqqCimh5NxnM7/FA4r7OF5sA
	 ulSXNbGqFG9KvtuduEOfBvUskiF+SoiYuahg089uvfCAORgJDm2HIR+eNXavpWrvzU
	 6m8CJaGeqs+uZzTMb9HyLNSdYRydk5AA7h1HlmFKlS3A4zc8515TMxosOU/TEdAW03
	 TTi2EdrdoRjMdQjLWMhTQ5V6s3r0INArWlknwyVBqO/OKi1WURVmykSBzqbwm6JG4r
	 iN5S/hMBPw8NqfZXgJNm50jkYqzdEU1PJiNoK7uJYQTjzXSgXcx66/pBgnSxNLdL1q
	 vs+wZhurqKBgA==
From: SeongJae Park <sj@kernel.org>
To: lirongqing <lirongqing@baidu.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: remove __read_mostly from memory_idle_ms_percentiles
Date: Fri, 30 Jan 2026 07:38:12 -0800
Message-ID: <20260130153813.784-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260130085603.1814-1-lirongqing@baidu.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 30 Jan 2026 03:56:03 -0500 lirongqing <lirongqing@baidu.com> wrote:

> From: Li RongQing <lirongqing@baidu.com>
> 
> The 'memory_idle_ms_percentiles' array in DAMON_STAT is updated
> frequently by the kernel to reflect the latest idle time statistics.
> Marking it as '__read_mostly' is inappropriate for data that is
> regularly written to, as it can lead to cache pollution in the
> read-mostly section.
> 
> Remove the '__read_mostly' annotation to accurately reflect the
> variable's usage pattern.

Nice catch, thank you Li!

> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
