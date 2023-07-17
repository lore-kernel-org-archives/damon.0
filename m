Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F9E253CD
	for <damon@lists.linux.dev>; Mon, 17 Jul 2023 19:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F82DC433C7;
	Mon, 17 Jul 2023 19:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689621125;
	bh=q1vjV+05Nobu+JpLPIvwaIeB762dezHqnRTiLlcmLCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Afsjf+VM9coDlrupkQv82KwZkzsnSQMABlMiP4DBvH0g3j2utCdj0/XkhiKDnj1w2
	 pq8VGIkhLua7XxjmwrfvEkuQzmjf/Ehwk0zut6ZsrNkDBoju3KhD3NmyEdWGdTqPkN
	 YGkIGDRwsoGvPf/1NWtEmVoIsdMyPEA4Ynk89ffOMXaBXe1FAM5UF9bbOvS2zeUs+u
	 JgrMUfo/xDZ5T+Y1IthQ2cjmPlv2lv81JMBAeAGrjSaHfWFrsRiZmAglQZFBVMAWZU
	 r6A2Glrgiym8X1Gq/gj7Ds01uC0bDREc+1rWk9KhL5l1oyXJlJCPn0oiTDTTCZ9vJb
	 yryDC6aA9T7+w==
From: SeongJae Park <sj@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/dbgfs: reduce stack usage in str_to_schemes()
Date: Mon, 17 Jul 2023 19:12:04 +0000
Message-Id: <20230717191204.29065-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c7a050b2-4ceb-9888-5e69-36aeec0989cc@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Chao,

On Mon, 17 Jul 2023 11:41:01 +0800 Chao Yu <chao@kernel.org> wrote:

> Hi all,
> 
> It warned because my config is wrong, sorry for the mistake, please
> ignore the patchset. :-P

No problem at all, appreciate for taking a look into DAMON :)


Thanks,
SJ

[...]
