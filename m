Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F8D3C68F
	for <damon@lists.linux.dev>; Wed, 29 Nov 2023 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ju5lIPl8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CC7C433C7;
	Wed, 29 Nov 2023 17:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701277861;
	bh=yIXGLLFPFr7RBt5CQB+D2IWUlHsvbAOtG6RShF9Nrwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ju5lIPl8700Nv3qzxPV7UcGNDOgnOBw10xs3PDmKLU1N19XY2sCB2JL7mMotDL7cE
	 76TEzHH0dlmdSiTQgo/3ILWaYuAFX9ttFRDZbIftUv/iOiOKQTM2ZhqtWAoPseuTVo
	 gZlhtiNJYxUHAplk4TLz/36JxT5YKuaNStiIUn6Zqg+yg1pAx877b2uJMs8NnwfZe5
	 664nYl7NrhLEMW4j+FNEa+EGi7LXf/1dROyqciMLLQEIAN+X2Dofctl/M9+B/SfnZD
	 iepu33luDFkkXwGNuA4FAtX7cH+ehzAmqlD3Zc4s1pn6TQBwgwOrVb+y45Of+AFXkb
	 OxVaUdOX+uZ0w==
From: SeongJae Park <sj@kernel.org>
To: cuiyangpei <cuiyangpei@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	xiongping1@xiaomi.com
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Date: Wed, 29 Nov 2023 17:10:58 +0000
Message-Id: <20231129171058.50270-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129131315.GB12957@cuiyangpei>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Cuiyangpei,

On Wed, 29 Nov 2023 21:13:15 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:

> Hi SeongJae,
> 
> We are using damon on the Android operating system. It starts monitoring
> when app comes to the foreground, stops monitoring and save the
> monitoring results when app goes to the background.

Thank you so much for sharing this detailed use case.  This will be very
helpful for us at understanding real usage of DAMON and making it better for
that together.

> 
> The two methods that you mentioned,
> 
> 1.tracepoint events
> This method requires opening the tracepoint event and using the
> 'perf-record' tool to generate the perf.data file. Then parsing the
> perf.data file. However, the user's phone is not enabled tracepoint
> events. Additionally, the generated file is quite complex, and we only
> need memory addresses and access frequency informations.

That's fair points, thank you for kindly explaining this.

> 
> 2. damos
> There is no direct Python runtime environment on android phones.
> 
> Both of these methods provide results that are not very intuitive and
> require complex parsing. We save the results in the format of starting
> address, region size, and access frequency. When the available memory
> reaches a threshold, the user space reclaim memory with low access
> frequency by calling 'process_madvise' function.

Again, very fair points.  So, if I understood correctly, you want to reclaim
cold pages proactively when the available memory reaches a threshold, right?
DAMON could do that directly instead of you[1].  Using that, you don't need to
save the access pattern and parse but just ask DAMON to find memory regions of
specific access frequency range and reclaim.  Have you also considered using
that but found some problems?

I understand the feature may not perfectly fit for your use case, and I want to
learn from you how it could be better.

[1] https://docs.kernel.org/mm/damon/design.html#operation-schemes


Thanks,
SJ

> 
> Thanks.
> 
[...]
