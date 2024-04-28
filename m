Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4913764CC0
	for <damon@lists.linux.dev>; Sun, 28 Apr 2024 19:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714331926; cv=none; b=ZzIAkTFIrfOEpUfBIJtNSIY9Nfq14gfW8kAG/gt8xYTcsjT+ffgio27/4RuUnqbxB8Q/SKsL9TuzeOORulrA5TNJ6NbUeqZFLT8KmJjRy8l6wGFwZP0QGh/YHCi6E4pN623CbP7v3dOnrn9nIzePuYhXp9EN3QgzwFAeB5DZJpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714331926; c=relaxed/simple;
	bh=zqbqGwJEz0gDkyq8DuVznseJOL7uJk6I0GVYIzg71P8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GyB9TcwBjnsKZ3U7n78W6xr52F0Yhph+/loPiqb12gDKjPoNMCYyo1qFh5eXl+1NbS0FzhaSq0gfv6tvABhlh4WocCVxVcwtYXEmnaVGJr2BqTXbxU0T0eWyYc4Yxs25OTR8KSqb4eiBzC6dzeZ6xvl1x2nsKx8kxJNWkjzzqWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLHR3cgH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLHR3cgH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830B4C113CC;
	Sun, 28 Apr 2024 19:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714331925;
	bh=zqbqGwJEz0gDkyq8DuVznseJOL7uJk6I0GVYIzg71P8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KLHR3cgHXv3o2geeFxITJo7Isl/tYuZjfYj1hIaAr59XfvbDKHWko7pUEuhr0fHvU
	 dg2ONU2ZhlPh3G79VSNDhCUi6uDkK/MwHpTHtw+1PBXdy02tXTGmBKZ1nvzmM4Vu6X
	 9Yrw0RDHWVnxvb7PiXAm4U3MiB6QDk71WNnRtOxBC0BF1DeOAoCKham7eUgXRbCX25
	 3Z8EvORo3an0yAkN0PLO8vei3ZzezyFa8pyyh5p/sGKP/Bu4FPRbn8KtdGxrZbipLx
	 Um/F/wc6hvD89PwQWDmO1Z7SSS5f0TRR1ZfcRUYUsRF8jUJUShFajkaOYqdwUFcwgH
	 1xyRCZ1VfE5pw==
From: SeongJae Park <sj@kernel.org>
To: Alex Rusuf <yorha.op@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH v3] mm/damon/core: Fix return value from damos_wmark_metric_value
Date: Sun, 28 Apr 2024 12:18:43 -0700
Message-Id: <20240428191843.92093-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240428191439.194027-1-yorha.op@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alex,

On Sun, 28 Apr 2024 22:14:39 +0300 Alex Rusuf <yorha.op@gmail.com> wrote:

> damos_wmark_metric_value's return value is 'unsigned long', so
> returning -EINVAL as 'unsigned long' may turn out to be
> very different from the expected one (using 2's complement) and
> treat as usual matric's value. So, fix that, checking if
> returned value is not 0.
> 
> Fixes: ee801b7dd782 ("mm/damon/schemes: activate schemes based on a watermarks mechanism")
> Signed-off-by: Alex Rusuf <yorha.op@gmail.com>

Thank you for patiently revisioning the patch!

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
