Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC548C08
	for <damon@lists.linux.dev>; Fri, 16 Dec 2022 23:59:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21543C433EF;
	Fri, 16 Dec 2022 23:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1671235189;
	bh=ZpoFq55Y77qd6uUfcxBgUK1ahaF0X0CW4r+vmI/epIU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PXLQLKOleQNajfC41/4kxoBQYi2lNdL4QOwCY2P0hsWiwMWTu2PJtuVvGj6hRWI2b
	 Coyjuev7HUBKyL3kYNG/NBdSHrxdzZvicb7Yd+n4B5gnAAJvVAgUfcWAGVCh3KUL/R
	 3rLKqUxW8QEEyHqQeyfc9KiHM8nnfH4EM8cLh0Gw=
Date: Fri, 16 Dec 2022 15:59:48 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] implement DAMOS filtering for anon pages and
Message-Id: <20221216155948.54023e407679736afcf00d9f@linux-foundation.org>
In-Reply-To: <20221205230830.144349-1-sj@kernel.org>
References: <20221205230830.144349-1-sj@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Dec 2022 23:08:19 +0000 SeongJae Park <sj@kernel.org> wrote:

> Subject: [PATCH 00/11] implement DAMOS filtering for anon pages and

I rewrote this to

implement DAMOS filtering for anon pages and/or specific memory cgroups
