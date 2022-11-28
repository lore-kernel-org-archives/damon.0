Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0638F6C
	for <damon@lists.linux.dev>; Mon, 28 Nov 2022 17:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFA3C433D6;
	Mon, 28 Nov 2022 17:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669656104;
	bh=TyPpfAWkaDgtWxdnYimbzfMlZJGlJ+ZXmhBXeP2ilQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dHaQJaP9VBsqcBayryYF/HinrdXV7jkLshA+U/eReLNdXc0YWDI4cKSvF6M8mbmDZ
	 vc0PXMnO63Tfdjgs3oQFY2CPoADgOeYEv4iYz1h8mq34u4kM6S8m4g0MkwwM9VPOpX
	 liEbT0Bg48TfXgCON64oDj88HTbf727TbyIbp+kKszE0fTdz8gTDqddNQTXzKWHyaK
	 faJcE0qcTSOGlveMjh1Kqz4Md8X25/xpZR5xIu9cLQF8Xue0TQSg4fnfm25f3HvbzP
	 Xt5EChCKhKPVN6uZ4qjVmwH5qm7q6StUILcSNENQlx2qYjh7NOu/hqS53As6p1KUzd
	 of+RZNRBaVVTw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-damon@amazon.com,
	linux-damon-trial@amazon.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date: Mon, 28 Nov 2022 17:21:42 +0000
Message-Id: <20221128172142.5402-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810225102.124459-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Wed, 10 Aug 2022 22:51:02 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> 
> In short, I'd like to start an open, regular, and informal virtual bi-weekly
> meeting series for DAMON community.
> 
> Important links and dates
> -------------------------
> 
> Location: https://meet.google.com/ndx-evoc-gbu
> Agenda: https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing
> 
> First instance: 2022-08-15 18:00 PDT
> Second instance: 2022-08-30 09:00 PDT

This is a reminder for the next instance of the chat series.  Next instance
will be 2022-11-28 (Mon) 18:00 PST, so about nine hours after now.  You can
show proposed agendas for the chat, or propose your own using the above Google
doc.  Hope to meet some of you :)


Thanks,
SJ
