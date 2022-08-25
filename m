Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E364C74
	for <damon@lists.linux.dev>; Thu, 25 Aug 2022 22:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938A6C433C1;
	Thu, 25 Aug 2022 22:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1661465006;
	bh=qqj1sPuIU2M5if+JbH3KWWswkdV/0dNUDeh0IvSKFtg=;
	h=From:To:Cc:Subject:Date:From;
	b=fsl6BuPVos27L0w8g+6EOItCVKILp9mDLjbYEWiXKpjPO+US7EgJrrgvD7M82zf+e
	 yzgwyTgBaJYJ8VyOu14Fs2/mchkB0bYgblVjP1jpwPd0bA82CWAKYl8okkcyNhv0hs
	 wdhtzlBMoNbJSTpd34G3zGz+1Oid0KIFlPAUNybcdekzx11Gxa9S4++7P7oUlTIxT5
	 oM2iio9FnF+NEJwPhANiOzEvNxBK5ZygJkM7Bvyx9rK4HldxCcTVhhHOVI0XXCdfI7
	 MrG85m38Lp/IfTj2/6/KDAc3lUow6xOcADZRTN/IInjPa3YG7TF84csTeIO1LZuqo7
	 zmtLmQL8iohzw==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [Reminder] DAMON debugfs interface will be removed
Date: Thu, 25 Aug 2022 22:03:19 +0000
Message-Id: <20220825220319.95226-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,


As announced before via the DAMON sysfs interface patchset[1] and also noted
in the document[2], DAMON debugfs interface already in new-feature-frozen state
and will be removed once next LTS kernel is released.  As there could be some
users who still depends on the debugfs interface and forgot about the
announcement, I just wanted to remind.

DAMON user-space tool, damo[3], has supported both interfaces since the
introduction of the sysfs interface and defaults to sysfs interface now, so the
users of damo would have no problem.  If you are still using the debugfs
interface, you could refer to that to know how you could use sysfs instead.

That said, there is no problem at extending the timeline if there is any
critical user issue, of course.  If you have such a critical issue, please let
me know.

[1] https://lore.kernel.org/all/20220228081314.5770-1-sj@kernel.org/
[2] https://docs.kernel.org/admin-guide/mm/damon/usage.html
[3] https://github.com/awslabs/damo


Thanks,
SJ
