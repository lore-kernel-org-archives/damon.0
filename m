Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4186E748D
	for <damon@lists.linux.dev>; Mon, 14 Nov 2022 16:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86792C433C1;
	Mon, 14 Nov 2022 16:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668444674;
	bh=9IOTMhVM4RJc931VeRVmeYbkyluCbLbtzk4jJQ7uS5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GgFZeDFwlznEdaAsXMtQTK3WK4q0RCAVDyjit6rb4A1lKGA6za5RtsvGFGBk73YTn
	 iGvBn73Pe6ceKywbyPBQ9Y5q2dQ1tw1YmZggQ4F9lb8et5PQ3XCP+4fXj81bJ/TjhX
	 nxuUxPt2JY+Sh49/7iMDPEyfpn8z2SNFlbx4aRegNT224+IhOdFc+GltL7rhprJeIB
	 dTWfMfm8t2kR36C4ejS19tSePjpATCb17hYk9g6jMNi1KQ6ATxY4aq6OG+7AIlpi8W
	 ZwFFgx5sy2Tza5T0hqovOOGyBIhej5M/cj6ABqhBbQx+/tg5FKowkMzcyGRe0edlA5
	 8YgdFv4JXvxag==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-damon@amazon.com,
	linux-damon-trial@amazon.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date: Mon, 14 Nov 2022 16:51:12 +0000
Message-Id: <20221114165112.21454-1-sj@kernel.org>
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

This is a reminder for the next instance of the chat series.  Next instance
will be 2022-11-15 (Tue) 09:30 PST.  You can show proposed agendas for the
chat, or propose your own using the above Google doc.  Hope to meet some of you
:)


Thanks,
SJ
