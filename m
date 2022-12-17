Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF208364
	for <damon@lists.linux.dev>; Sat, 17 Dec 2022 00:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6065C433EF;
	Sat, 17 Dec 2022 00:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671235376;
	bh=5A1aij+Hegtx0u914TiIF50pW15xVFJBSfDFBSTowrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oKS0sSfQh20gJwHqeDNttj9nsgLT4ClpeLJnQfPM65F0zBz7SrbJPUWoqLnPL1KLH
	 BpSb1GvhGZMmg9o1FOEr0ERNKa/D978rJHDBwwi45xlDzY/+0XZa4ALrhUJ2iz/fsj
	 eUL2rIvaEw7RXz7kVeqQ3F6/c+hWTq/219sZBF/n139agHMsLCCK022Qt1V//b2c36
	 UWo8YHkgd8+Cr8sOCtQfJs978hiEIR1Pgh0Syok9DBnjzvgZS+09f9ZdjHwXJiex61
	 wJaaxyYCOd7gyRMVwKUulYc70koddviL8ZHKHzVefySoW06LQv4KYIKrruiru5dwoi
	 s9BtTaYLQuZ/w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] implement DAMOS filtering for anon pages and
Date: Sat, 17 Dec 2022 00:02:54 +0000
Message-Id: <20221217000254.59126-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221216155948.54023e407679736afcf00d9f@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 16 Dec 2022 15:59:48 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon,  5 Dec 2022 23:08:19 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > Subject: [PATCH 00/11] implement DAMOS filtering for anon pages and
> 
> I rewrote this to
> 
> implement DAMOS filtering for anon pages and/or specific memory cgroups

Sounds much better, thank you Andrew!


Thanks,
SJ
