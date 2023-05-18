Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0366F6FB8
	for <damon@lists.linux.dev>; Thu, 18 May 2023 18:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CEDC433EF;
	Thu, 18 May 2023 18:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684436014;
	bh=thqrSXP2BC4DJH528QS5GyiNrs8cMPzkwGyIFD1nCJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J5diEBTFWPRmnysYUv7xoYJby573VfnCZMCzKJqPQjQvhPcDvP/omE39ca3hW/UWR
	 qELgAtdtA/F95wW/eszgom61yzzy1jE0kU1PNHbd+tYS+5sk+MSP7HvaT3KVCbxopa
	 UGU0nErFkIlBLPTsWvrp2G97V2kQnNnwaL8T3b+7NaPCtTRJimeuJzFufVAaFAmOSV
	 tjvTZczt5ek+xcz4tRYEbq+Erhtkqsihmgd+5vVKRERtwYrBmDeuUyQsHFt6GplBKc
	 pbgjFquYxtd4Zg423XCF2SESfsrpCFmumjjAqBJ6Z+OOxgcleo8rcoumwM9NbVzRjs
	 Q9e40buk8enLA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-damon@amazon.com,
	linux-damon-trial@amazon.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date: Thu, 18 May 2023 18:53:32 +0000
Message-Id: <20230518185332.84180-1-sj@kernel.org>
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

The next instance was originally scheduled ror 2023-05-29.  But I realized it's
a holiday in USA.  So I rescheduled it to 2023-05-30.  Please refer to the
Agenda doc whenever you unsure the schedules.


Thanks,
SJ
