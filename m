Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F02368
	for <damon@lists.linux.dev>; Sun, 18 Sep 2022 02:43:05 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1663468603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mt4EevSP2UXpOuDshgDqIVBSaTOuTupp17SEl5NDqXg=;
	b=TJvEPU5EJxYQYfqjeqgXwtBInyVyBZ9dIKb7eJCybflERk/L6hMKDFVlSpHNOVON8Tey/m
	DSCEb9RgIRzqUnB9f+AQLBzUD3udAl/bn2PFN9r/Lr8xwJg5W37xRYbRY8KsLPX/KUSL46
	PwOhViZkUj8Q5M5elAIVdQs7HM/kApA=
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/damon: return void from damon_set_schemes()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <1663341635-12675-1-git-send-email-kaixuxia@tencent.com>
Date: Sun, 18 Sep 2022 10:36:39 +0800
Cc: sj@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 damon@lists.linux.dev,
 Linux MM <linux-mm@kvack.org>,
 linux-kernel@vger.kernel.org,
 Kaixu Xia <kaixuxia@tencent.com>
Content-Transfer-Encoding: 7bit
Message-Id: <6843CCD1-F6F3-40AA-9A5C-7DFD65475864@linux.dev>
References: <1663341635-12675-1-git-send-email-kaixuxia@tencent.com>
To: xiakaixu1987@gmail.com
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev



> On Sep 16, 2022, at 23:20, xiakaixu1987@gmail.com wrote:
> 
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> There is no point in returning an int from damon_set_schemes().
> It always returns 0 which is meaningless for the caller, so
> change it to return void directly.
> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

