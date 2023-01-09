Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FD02C9D
	for <damon@lists.linux.dev>; Mon,  9 Jan 2023 11:57:34 +0000 (UTC)
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4NrByS0d9gzW26
	for <damon@lists.linux.dev>; Mon,  9 Jan 2023 19:47:44 +0800 (CST)
Received: from mxus.zte.com.cn (unknown [10.207.168.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4NrBxz1rNrz4xBTj
	for <damon@lists.linux.dev>; Mon,  9 Jan 2023 19:47:19 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxus.zte.com.cn (FangMail) with ESMTPS id 4NrBxp1SXdz9tyDF
	for <damon@lists.linux.dev>; Mon,  9 Jan 2023 19:47:10 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NrBxc0fcLz8QrkZ;
	Mon,  9 Jan 2023 19:47:00 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
	by mse-fl1.zte.com.cn with SMTP id 309BkqU1093359;
	Mon, 9 Jan 2023 19:46:52 +0800 (+08)
	(envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
	by mapi (Zmail) with MAPI id mid14;
	Mon, 9 Jan 2023 19:46:55 +0800 (CST)
Date: Mon, 9 Jan 2023 19:46:55 +0800 (CST)
X-Zmail-TransId: 2b0363bbfeafffffffffb62deb1a
X-Mailer: Zmail v1.0
Message-ID: <202301091946553770006@zte.com.cn>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
From: <yang.yang29@zte.com.cn>
To: <sj@kernel.org>
Cc: <akpm@linux-foundation.org>, <damon@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <xu.panda@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIG1tL2RhbW9uL3N5c2ZzLXNjaGVtZXM6IHVzZSBzdHJzY3B5KCkgdG8gaW5zdGVhZCBvZiBzdHJuY3B5KCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 309BkqU1093359
X-FangMail-Bounce-Flag: 1673264830.63BBFEBC.000
X-FangMail-Outinfo: 1673264830/63BBFEBC.000/4NrBxp1SXdz9tyDF/yang.yang29@zte.com.cn/1
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.14.novalocal with ID 63BBFEDF.000 by FangMail milter!
X-FangMail-Envelope: 1673264864/4NrByS0d9gzW26/63BBFEDF.000/10.35.20.165/[10.35.20.165]/mxde.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63BBFEDF.000/4NrByS0d9gzW26

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL-terminated strings.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 mm/damon/sysfs-schemes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index f0dabe3e2dc0..86edca66aab1 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -353,8 +353,7 @@ static ssize_t memcg_path_store(struct kobject *kobj,
 	if (!path)
 		return -ENOMEM;

-	strncpy(path, buf, count);
-	path[count] = '\0';
+	strscpy(path, buf, count + 1);
 	filter->memcg_path = path;
 	return count;
 }
-- 
2.15.2
