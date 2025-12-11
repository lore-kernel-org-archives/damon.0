Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2412623D7FD
	for <damon@lists.linux.dev>; Thu, 11 Dec 2025 07:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765439690; cv=none; b=KGAmsZWP6tUOUiB+xKD7WUPKLxjS9QbvXQZ/YYRafq1k2NkjxAIuyipHKi+YDXeq/tygOd70WNQfRzdfSrA/WMYnp+5/MSp4ByrWn1ksYpPcyVIysrGPYsXZOwSqnjHNLBAPVRjdFye9YlFcCroD9cCvMio+Ewc2PFYAkaP0lgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765439690; c=relaxed/simple;
	bh=EDeluHou9aG+5ofz/75w99Jw9fNkvfk+DkdrB9VQgSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGWDDhGCQUa3hdU8UbZoHTNzRa+Et6q9uilOK8g+pMkN0OzABXdJlXVcEbkwLa0J+hq9yhPlXJlpFkblVtmKXmHfoUIq3ZBa6GOPOaj+wp9/Zt68UScIsNUwFa0fnFx4NkMwEyBPwpPZCwq9ml1+lqdY6p0n+/kjgDrqhsLoYr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXiuu9X9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXiuu9X9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5D0C4CEFB;
	Thu, 11 Dec 2025 07:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765439689;
	bh=EDeluHou9aG+5ofz/75w99Jw9fNkvfk+DkdrB9VQgSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZXiuu9X9eSUWidUeB6MH/D30b2w4C3tHcMSJiWyCsV5B4bsl8MFbiq7qr5kIswMnQ
	 ntjDBpcGNPXtCCSQJhHss/StIVv5iETsCB3zT9E5L08DlKZs4AkFNbNKdDEn6HPPCE
	 PMZ8iWbbIzQ/ZGiaASKHStqIgyr/Q/828i9K1NvkUaZWe/etZlJbDK1kG6x6BpcSoD
	 hLlUA4ZkvOzNV+d6Y3iv0xS3katYPXh3bK7YjktIQArnHLxICUuWobMVkginDdnnWQ
	 qz+OjcgnLhNynDp9aZmzIY4TB0LP6SWAw+Err363aZiYT2aYqnjaOOEBK5bQPKvjRp
	 aOnmgfHCLg/fw==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: modified damon_call_control from static to kmalloc
Date: Wed, 10 Dec 2025 23:54:46 -0800
Message-ID: <20251211075446.75355-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC7epLcuK-58kaROWMof9dq3ZCm2WV218KGv7kcDMf7q-Q@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 11 Dec 2025 16:38:46 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> On Thu, 11 Dec 2025 at 15:04, SeongJae Park <sj@kernel.org> wrote:
[...]
> > Sounds good.  Would you mind sending a patch for that?
> 
> Would you like me to send you the patch with only the comments corrected?

I was just asking your preferrence, and seems you have no strong one.  I will
do that on my own unless you mind.


Thanks,
SJ

[...]
