Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7005391
	for <damon@lists.linux.dev>; Tue, 16 Aug 2022 16:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FD6C433D6;
	Tue, 16 Aug 2022 16:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660667271;
	bh=KBYXwe1X2n4opJhOS1+wH3Dye40jHyb5yyP7gFh1i90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fvm70g5FOUdMgNwU4rRkE+WVdax/qskBoxPyGrWzly347vrs+eIVFRkb4Xr6XqeJZ
	 l/a+hW26lg7YuGeONf/ach2B0K5uEvmk//aUoqCAGwbBfTcuu9M4KSWy5dEskz5Kcg
	 phIlRFYp3BsRRjsCAIL0yQphcXWRUsbRJUjAmwqM6CBC3lz/wm8zefhzIX4tkno2Nv
	 QSFD+XnmBu7dBxdsoaupKrbtYYMZWBi1Q2IzyaXsYKz4EJLPmgEccRHXrbo0q4vADf
	 igWnO2aVKS84bVOeBIHVm6ocPqillsR27zjzpoPYozGurLpwvYuE+jI7KFa+Z0kpMh
	 5ze7fgnsaB2LA==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev,
	linux-damon@amazon.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: brief and incomplete summary of the first instance of the series
Date: Tue, 16 Aug 2022 16:27:28 +0000
Message-Id: <20220816162728.96821-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: 20220810225102.124459-1-sj@kernel.org
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,


Yesterday, we had the first instance of the DAMON Beer/Coffee/Tea chat
series[1], which is intended to be an open, regular, and informal
community-based bi-weekly syncup meeting for DAMON.  I was very excited to meet
with the community people who have interest in DAMON and exchange our name in
voice.  Thank you again to all people who joined in yesterday.  Below is a
brief and incomplete summary of the yesterday meeting.  Note that I will only
occasionally post this kind of summaries, not for every instance of the series.

- Several people from various org including Tencent, Intel, AWS, and some
  universities joined.
- We introduced ourselves and for what we want to use DAMON.
- SJ introduced current DAMON development process, long term future plans, and
  near-future plans.
- There were some questions.
  - Why DAMON debugfs has number of target ids limit of 32?
    - No reason at all.  Please feel free to post a patch for increasing or
      removing the limit.
  - What's the plan for DAMON's cgroup support?
    - The rough idea is to receive cgroup id as the target id of DAMON.
    - Definitely need more works.

If there is something I missed or wrong, please let me know.

Next instance of the series will be held at 2022-08-30 09:00 PDT using the
Google Meet[2].  Please feel free to propose any agenda on the Google Doc[3].

Looking forward to meet more community people there!

[1] https://lore.kernel.org/damon/20220810225102.124459-1-sj@kernel.org/
[2] https://meet.google.com/ndx-evoc-gbu
[3] https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing


Thanks,
SJ
