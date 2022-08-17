Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE909441D
	for <damon@lists.linux.dev>; Wed, 17 Aug 2022 16:07:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B44DC433D7;
	Wed, 17 Aug 2022 16:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1660752443;
	bh=+IgIwGvGsv8iGPY4KtPJvSs69LJqZ76GCMTQrQxbLaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ON2nnV9tohORfB7RYdUVQqEVQx5DBj5w3rUZDAqpajXdpG4bGTcaztknIh3QRinrw
	 87CMK3RSMKo1zzt5By6CcBmv5SabudtIaVV6HwVS38x74iVfOZ0Ax7pGnClxZStQoi
	 hwXgTEssSu04qV1vHeQK5gu9Pjnoi3yLzoZeXu4k=
Date: Wed, 17 Aug 2022 09:07:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: sj@kernel.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Validate if the pmd entry is present before
 accessing
Message-Id: <20220817090722.3a04da77a280c74cccde6b2c@linux-foundation.org>
In-Reply-To: <2838b6737bc259cf575ff11fd1c4b7fdb340fa73.1660717122.git.baolin.wang@linux.alibaba.com>
References: <2838b6737bc259cf575ff11fd1c4b7fdb340fa73.1660717122.git.baolin.wang@linux.alibaba.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Aug 2022 14:21:12 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> The pmd_huge() is used to validate if the pmd entry is mapped by a huge
> page, also including the case of non-present (migration or hwpoisoned)
> pmd entry on arm64 or x86 architectures. Thus we should validate if it
> is present before making the pmd entry old or getting young state,
> otherwise we can not get the correct corresponding page.
> 

What are the user-visible runtime effects of this change?
