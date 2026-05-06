Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC1D30AD1A;
	Wed,  6 May 2026 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778085668; cv=none; b=sqi5DN23w4XWJV1k3IFWKhDqiDh0cIbkPaDajSCXiQECc+q+1LxagAFQ/93golXvggFeLLH2TyXtwOQI2JILT5rL1QnSJJMV5f1DQqTr6MFLsAYFPlROkFZ1chb5ApywcQYWHgs0SNN/3d5eX5ZgD93jiw4HSvKXM/WrMDC2RNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778085668; c=relaxed/simple;
	bh=sjh30b3c1z/W1cQGXVs6VKN8mBptz52vyltQa8qkOPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mArzOtLRJV1mAC03ZOeooYZ7zqXlwD+mHbwGER9YSzyv1oFCwRoCtl3hZDXXiJMkjqi6bNRX2JH48nqfe3q4KOBJJULuJjPNtFNwNHw/6KJ6vkxfmFp0wkWWrTmL3iWk8NOBYnXAJxFGHJLd5B67iCyTwgnefY44QGjCsnmBn+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrtaON3l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrtaON3l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A988AC2BCB0;
	Wed,  6 May 2026 16:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778085668;
	bh=sjh30b3c1z/W1cQGXVs6VKN8mBptz52vyltQa8qkOPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hrtaON3lluhILxsDmGjMLJkWvBV5Pu5iVtIu4aBxZytPYMAh9RGWmzbVgNiWfy/Zt
	 iGK/dQndwuyOK/t+Q+02gAAz0xZ5YjKQAc1DfgXgmQ8ChJfTyU1hZtb3Ef3hdRevu3
	 VRYunv4LniTGy/fhxZQ3E0cYulJdSy3ZDl9pnyKbPI6AdOYt4tJ4LyWPcah7TR2o/v
	 dDlGj1pEv5koHErR8j4+kTxYkbcheIKRhjJyjAiXDhqJaJrVw9Wbc39ardBx+UM+eF
	 Zv84n87GLrdrenCQrns5nhNZe+f1MYuQlQoNENosx1gm002LxIJvCvkpVN6L91V7rC
	 fg0gjX7Y/ttXA==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/4] mm/damon: Introduce a huge page collapsing mechanism using auto tuning
Date: Wed,  6 May 2026 09:41:02 -0700
Message-ID: <20260506164103.6414-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2446b1e8-2b9a-4621-bbb3-ccec0f1aa604@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 4 May 2026 16:52:01 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> On 5/1/2026 3:41 AM, SeongJae Park wrote:
> > Hello Asier,
> Hi, sorry for the delayed answer.

No worry, no rush.  Take your time :)

> > 
> > On Thu, 30 Apr 2026 13:41:35 +0000 <gutierrez.asier@huawei-partners.com> wrote:
[...]
> >> A new module is introduced to demonstrate the use of huge pages
> >> collapse autotuning. The module launches a kdamond thread for a 
> >> certain task provided by the user through monitored_pid module argument.
> > 
> > If it is only for demonstration, I think it is more fit to be a sample module
> > (placed under samples/damon/).
> We are testing this in a bare metal MySQL server. Maybe the description
> was not the most accurate.

Do you mean it is not only for demonstration but a real world use case and
therefore better not to be a sample module?

> >>
> >> This module also has a user autotuning knob which allows the user to
> >> adjust the aggressiveness of page collapsing.
> >>
> >> Benchmarks
> >> ================
> >> In progress, will add them in the next RFC series.
> > 
> > Looking forward to!
> > 
> > I may request not that much test results for the quota goal.  If the module is
> > not just a sample but for a real world use case, I may hope somewhat reasonable
> > test resulsts.
> OK, will do it.

Thank you for kindly and flexibly accepting my humble suggestions :)


Thanks,
SJ

[...]
