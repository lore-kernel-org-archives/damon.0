Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42D529AC
	for <damon@lists.linux.dev>; Wed, 14 Sep 2022 07:09:49 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1663139382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVX6wYCHr1Muv7U0ni5Gzy2veBGOaOy55vMQEkKeVcQ=;
	b=Uld1IRw7cd2UeCsv9VvNSYSOIwpWe6WMbNLFPrY9Jm3N/ueWiCELRf6BnRNL/+AT8xkzvK
	pvrT2q2C5VNEpByBOm6RPh815qDwHDO5OB7/ETDNXA6U4CvmliwBCHQ0zDPly8ibYVmrQ/
	2I9NW4SdJhl2vKELRqBR/VrIe5qDtlI=
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/damon/sysfs: use the wrapper directly to check if the
 kdamond is running
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <1662995513-24489-1-git-send-email-kaixuxia@tencent.com>
Date: Wed, 14 Sep 2022 15:09:38 +0800
Cc: sj@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 damon@lists.linux.dev,
 Linux MM <linux-mm@kvack.org>,
 linux-kernel@vger.kernel.org,
 Kaixu Xia <kaixuxia@tencent.com>
Content-Transfer-Encoding: 7bit
Message-Id: <D28241BF-FEE4-49C1-AC4E-B1A48240E193@linux.dev>
References: <1662995513-24489-1-git-send-email-kaixuxia@tencent.com>
To: xiakaixu1987@gmail.com
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev



> On Sep 12, 2022, at 23:11, xiakaixu1987@gmail.com wrote:
> 
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> We can use the 'damon_sysfs_kdamond_running()' wrapper directly to
> check if the kdamond is running in 'damon_sysfs_turn_damon_on()'.
> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

